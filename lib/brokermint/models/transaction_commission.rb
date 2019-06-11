module Brokermint
  class TransactionCommission < BaseModel
    attribute :id
    attribute :item_index
    attribute :name
    attribute :item_type
    attribute :side
    attribute :payer_id
    attribute :payer_type
    attribute :payee_id
    attribute :payee_type
    attribute :sliding_base
    attribute :sliding_base_period
    attribute :calculated_dollar_amount
    attribute :minimum_dollar_amount
    attribute :pay_to, TransactionCommissionPayee
    attribute :custom_sliding_base_period
    attribute :sliding_base_amount
    attribute :applied_plan
    attribute :maximum_dollar_amount
    attribute :prorated_according_to
    attribute :sliding_base_accrued_by
    attribute :tiers, Array(TransactionCommissionTier)
    attribute :tags
    attribute :payee_name
    attribute :payee_first_name
    attribute :payee_last_name
    attribute :payee_company
    attribute :payer_name
  end
end
