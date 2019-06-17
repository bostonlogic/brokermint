module Brokermint
  class TransactionDocument < BaseModel
    attribute :id
    attribute :name
    attribute :upload_status
    attribute :url

    attribute :transaction_id
    attribute :content_type
    attribute :path
  end
end
