module Brokermint
  class TransactionCommissionResource < ResourceKit::Resource
    include ErrorHandlingResourcable

    resources do
      # GET /transactions/:transaction_id/commissions
      action :all do
        verb :get
        path "#{Brokermint.configuration.path_url}/transactions/:transaction_id/commissions"
        handler(200) { |response| TransactionCommissionMapping.extract_collection(response.body, :read) }
      end
    end

  end
end
