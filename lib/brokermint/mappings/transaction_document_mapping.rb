module Brokermint
  class TransactionDocumentMapping
    include Kartograph::DSL

    kartograph do
      mapping TransactionDocument

      scoped :read do
        property :id
        property :name
        property :upload_status
        property :url
      end

      scoped :create do
        property :transaction_id
        property :name
        property :content_type
        property :path
      end

      scoped :created do
        property :id
      end

    end
  end
end
