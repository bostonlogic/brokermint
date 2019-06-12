module Brokermint
  class TransactionParticipant < BaseModel
    attribute :id
    attribute :role
    attribute :type
    attribute :owner
    attribute :email
    attribute :first_name
    attribute :last_name
  end
end
