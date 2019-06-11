module Brokermint
  class Transaction < BaseModel
    attribute :id
    attribute :address
    attribute :city
    attribute :state
    attribute :zip
    attribute :status
    attribute :price
    attribute :transaction_type
    attribute :representing
    attribute :acceptance_date
    attribute :expiration_date
    attribute :created_at
    attribute :updated_at
    attribute :closing_date
    attribute :total_gross_commission
    attribute :listing_date
    attribute :external_id
    attribute :timezone
    attribute :commissions_finalized_at
    attribute :custom_id
    attribute :closed_at
    attribute :custom_attributes, Array(CustomAttribute)
    attribute :buying_side_representer, Representer
    attribute :listing_side_representer, Representer
  end
end
