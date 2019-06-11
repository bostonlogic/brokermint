module Brokermint
  class User < BaseModel
    attribute :id
    attribute :email
    attribute :created_at
    attribute :updated_at
    attribute :first_name
    attribute :last_name
    attribute :phone
    attribute :active
    attribute :birthday
    attribute :company
    attribute :external_id
    attribute :role
    attribute :anniversary_date
    attribute :team
    attribute :address
    attribute :city
    attribute :state
    attribute :zip
    attribute :license_number
    attribute :license_expiration
    attribute :avatar_url

    attribute :sso_token
  end
end
