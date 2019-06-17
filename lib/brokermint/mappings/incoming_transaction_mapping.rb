module Brokermint
  class IncomingTransactionMapping
    include Kartograph::DSL

    kartograph do
      mapping IncomingTransaction

      scoped :read do
        property :id
        property :external_id
      end

      scoped :create do
        property :source_id
        property :transactions, plural: true, include: TransactionAttributeMapping
      end

    end
  end
end
