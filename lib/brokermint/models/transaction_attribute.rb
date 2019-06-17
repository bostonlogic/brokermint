module Brokermint
  class TransactionAttribute < BaseModel
    attribute :id
    attribute :agent_id
    attribute :agent_name
    attribute :address
    attribute :city
    attribute :state
    attribute :zip
    attribute :status
    attribute :price
    attribute :listing_date
    attribute :expiration_date
    attribute :acceptance_date
    attribute :closing_date
    attribute :transaction_type
    attribute :custom_attributes, CustomTransactionAttribute
  end
end
