module Brokermint
  class TransactionParticipantMapping
    include Kartograph::DSL

    kartograph do
      mapping TransactionParticipant

      scoped :read do
        property :id
        property :role
        property :type
        property :owner
        property :email
        property :first_name
        property :last_name
      end

      scoped :create do
        property :id
        property :role
        property :owner
      end

    end
  end
end
