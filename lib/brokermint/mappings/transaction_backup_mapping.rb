module Brokermint
  class TransactionBackupMapping
    include Kartograph::DSL

    kartograph do
      mapping TransactionBackup

      scoped :all do
        property :id
        property :completed_at
        property :file_name
        property :link
      end

      scoped :read do
        property :link
      end
    end
  end
end
