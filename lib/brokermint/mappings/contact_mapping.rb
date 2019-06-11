module Brokermint
  class ContactMapping
    include Kartograph::DSL

    kartograph do
      mapping Contact

      scoped :all do
        property :id
        property :contact_type
        property :first_name
        property :last_name
        property :email
      end

      scoped :read do
        property :id
        property :contact_type
        property :first_name
        property :last_name
        property :company
        property :address
        property :city
        property :state
        property :zip
        property :email
        property :phone
        property :mobile_phone
        property :fax
        property :comments, plural: true, include: CommentMapping
        property :created_at
        property :updated_at
        property :lead_source
        property :created_by
        property :private
        property :external_id
        property :custom_attributes, plural: true, include: CustomAttributeMapping
      end

      scoped :create, :update do
        property :contact_type
        property :first_name
        property :last_name
        property :company
        property :address
        property :city
        property :state
        property :zip
        property :email
        property :phone
        property :mobile_phone
        property :fax
        property :comments, plural: true, include: CommentMapping
        property :lead_source
        property :created_by
        property :private
        property :external_id
        property :custom_attributes, plural: true, include: CustomAttributeMapping
      end

    end
  end
end
