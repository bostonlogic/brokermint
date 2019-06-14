module Brokermint
  class TransactionTaskMapping
    include Kartograph::DSL

    kartograph do
      mapping TransactionTask

      scoped :read do
        property :id
        property :name
        property :description
        property :document_required
        property :done
        property :deadline
        property :comments, plural: true, include: CommentMapping
        property :created_at
        property :updated_at
        property :exemption
        property :submitted_at
        property :document_id
      end

      scoped :create, :update do
        property :name
        property :description
        property :document_required
        property :done
        property :deadline
        property :comments, plural: true, include: CommentMapping
        property :exemption
        property :submitted_at
        property :document_id
      end

    end
  end
end
