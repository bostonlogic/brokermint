module Brokermint
  class Contact < BaseModel
    attribute :id
    attribute :contact_type
    attribute :first_name
    attribute :last_name
    attribute :company
    attribute :address
    attribute :city
    attribute :state
    attribute :zip
    attribute :email
    attribute :phone
    attribute :mobile_phone
    attribute :fax
    attribute :comments
    attribute :created_at
    attribute :updated_at
    attribute :lead_source
    attribute :created_by
    attribute :private
    attribute :external_id
    attribute :custom_attributes, Array(CustomAttribute)
  end
end
