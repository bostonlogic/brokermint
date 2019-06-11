module Brokermint
  class TransactionCommissionPayeeMapping
    include Kartograph::DSL

    kartograph do
      mapping TransactionCommissionPayee

      scoped :read do
        property :name
        property :address
        property :city
        property :state
        property :zip
      end

    end
  end
end
