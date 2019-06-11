module Brokermint
  class TransactionCommissionMapping
    include Kartograph::DSL

    kartograph do
      mapping TransactionCommission

      scoped :read do
        property :id
        property :item_index
        property :name
        property :item_type
        property :side
        property :payer_id
        property :payer_type
        property :payee_id
        property :payee_type
        property :sliding_base
        property :sliding_base_period
        property :calculated_dollar_amount
        property :minimum_dollar_amount
        property :pay_to, include: TransactionCommissionPayeeMapping
        property :custom_sliding_base_period
        property :sliding_base_amount
        property :applied_plan
        property :maximum_dollar_amount
        property :prorated_according_to
        property :sliding_base_accrued_by
        property :tiers, plural: true, include: TransactionCommissionTierMapping
        property :tags
        property :payee_name
        property :payee_first_name
        property :payee_last_name
        property :payee_company
        property :payer_name
      end

    end
  end
end
