
module Brokermint
  class IncomingTransaction < BaseModel
    attribute :source_id
    attribute :transactions, Array(TransactionAttribute)

    attribute :id
    attribute :external_id
  end
end
