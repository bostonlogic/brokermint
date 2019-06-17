# Create: POST https://my.brokermint.com/api/v1/incoming_transactions

module Brokermint
  class IncomingTransactionResource < ResourceKit::Resource
    include ErrorHandlingResourcable

    resources do
      # POST /incoming_transactions
      action :create do
        verb :post
        body { |object| IncomingTransactionMapping.representation_for(:create, object) }
        path "#{Brokermint.configuration.path_url}/incoming_transactions"
        handler(200) { |response| IncomingTransactionMapping.extract_collection(response.body, :read) }
      end
    end

  end
end
