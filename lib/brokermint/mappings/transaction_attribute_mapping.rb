module Brokermint
  class TransactionAttributeMapping
    include Kartograph::DSL

    kartograph do
      mapping TransactionAttribute

      scoped :create do
        property :id
        property :agent_id
        property :agent_name
        property :address
        property :city
        property :state
        property :zip
        property :status
        property :price
        property :listing_date
        property :expiration_date
        property :acceptance_date
        property :closing_date
        property :transaction_type
        property :custom_attributes, include: CustomTransactionAttributeMapping
      end

    end
  end
end
