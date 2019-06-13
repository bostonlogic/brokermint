module Brokermint
  class TransactionChecklistMapping
    include Kartograph::DSL

    kartograph do
      mapping TransactionChecklist

      scoped :read do
        property :id
        property :name
      end

    end
  end
end
