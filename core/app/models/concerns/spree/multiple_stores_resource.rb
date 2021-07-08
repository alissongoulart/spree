module Spree
  module MultipleStoresResource
    extend ActiveSupport::Concern

    included do
      scope :for_store, ->(store) { joins(:stores).where(Store.table_name => { id: store.id }) }

      validate :must_have_one_store, unless: :disable_store_presence_validation?
    end

    protected

    def must_have_one_store
      return if stores.any?

      errors.add(:stores, Spree.t(:must_have_one_store))
    end

    # this can be overriden on model basis
    def disable_store_presence_validation?
      false
    end
  end
end
