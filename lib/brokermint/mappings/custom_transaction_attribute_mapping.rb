module Brokermint
  class CustomTransactionAttributeMapping
    include Kartograph::DSL

    kartograph do
      mapping CustomTransactionAttribute

      scoped :create do
        property :bedrooms, key: 'Bedrooms'
        property :total_baths, key: 'Total baths'
        property :legal_description, key: 'Legal description'
        property :property_type, key: 'Property type'
        property :zoning, key: 'Zoning'
        property :showing_phone, key: 'Showing phone'
        property :lockbox, key: 'Lockbox'
        property :owner_phone, key: 'Owner phone'
        property :sqft, key: 'SQFT'
        property :agent_remarks, key: 'Agent remarks'
        property :description, key: 'Description'
        property :mls_number, key: 'MLS #'
        property :area, key: 'Area'
        property :owner_name, key: 'Owner name'
        property :county, key: 'County'
        property :showing_instructions, key: 'Showing instructions'
        property :apn, key: 'APN'
        property :public_remarks, key: 'Public remarks'
      end

    end
  end
end
