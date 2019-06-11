module Brokermint
  class TransactionCommissionTierMapping
    include Kartograph::DSL

    kartograph do
      mapping TransactionCommissionTier

      scoped :read do
        property :id
        property :commission_item_id
        property :low_limit
        property :value
        property :uom
      end

    end
  end
end
