module Brokermint
  class TransactionMapping
    include Kartograph::DSL

    kartograph do
      mapping Transaction

      scoped :read do
        property :id
        property :address
        property :city
        property :state
        property :zip
        property :status
        property :price
        property :transaction_type
        property :representing
        property :acceptance_date
        property :expiration_date
        property :created_at
        property :updated_at
        property :closing_date
        property :total_gross_commission
        property :listing_date
        property :external_id
        property :timezone
        property :commissions_finalized_at
        property :custom_id
        property :closed_at
        property :custom_attributes, plural: true, include: CustomAttributeMapping
        property :buying_side_representer, include: RepresenterMapping
        property :listing_side_representer, include: RepresenterMapping
      end

      scoped :create, :update do
        property :address
        property :city
        property :state
        property :zip
        property :status
        property :price
        property :transaction_type
        property :representing
        property :acceptance_date
        property :expiration_date
        property :closing_date
        property :total_gross_commission
        property :listing_date
        property :external_id
        property :timezone
        property :commissions_finalized_at
        property :custom_id
        property :closed_at
        property :custom_attributes, plural: true, include: CustomAttributeMapping
        property :buying_side_representer, include: RepresenterMapping
        property :listing_side_representer, include: RepresenterMapping
      end

    end
  end
end
