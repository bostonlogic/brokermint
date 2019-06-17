module Brokermint
  class TransactionNoteMapping
    include Kartograph::DSL

    kartograph do
      mapping TransactionNote

      scoped :create do
        property :text
      end

    end
  end
end
