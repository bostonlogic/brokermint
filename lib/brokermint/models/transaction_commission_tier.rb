module Brokermint
  class TransactionCommissionTier < BaseModel
    attribute :id
    attribute :commission_item_id
    attribute :low_limit
    attribute :value
    attribute :uom
  end
end
