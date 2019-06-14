module Brokermint
  class TransactionTask < BaseModel
    attribute :id
    attribute :name
    attribute :description
    attribute :document_required
    attribute :done
    attribute :deadline
    attribute :comments, Array(Comment)
    attribute :created_at
    attribute :updated_at
    attribute :exemption
    attribute :submitted_at
    attribute :document_id
  end
end
