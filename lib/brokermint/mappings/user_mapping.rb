module Brokermint
  class UserMapping
    include Kartograph::DSL

    kartograph do
      mapping User

      scoped :all do
        property :id
        property :email
        property :first_name
        property :last_name
        property :company
      end

      scoped :read do
        property :id
        property :email
        property :created_at
        property :updated_at
        property :first_name
        property :last_name
        property :phone
        property :active
        property :birthday
        property :company
        property :external_id
        property :role
        property :anniversary_date
        property :team
        property :address
        property :city
        property :state
        property :zip
        property :license_number, key: 'license_#'
        property :license_expiration
        property :avatar_url
      end

      scoped :sso_token do
        property :sso_token
      end

    end
  end
end
