# List: GET https://my.brokermint.com/api/v1/transactions/<transaction-id>/checklists
# Show: GET https://my.brokermint.com/api/v1/transactions/<transaction-id>/checklists/<checklist-id>

module Brokermint
  class TransactionChecklistResource < ResourceKit::Resource
    include ErrorHandlingResourcable

    resources do

      # GET /transactions/:transaction_id/checklists
      action :all do
        verb :get
        path "#{Brokermint.configuration.path_url}/transactions/:transaction_id/checklists"
        handler(200) { |response| TransactionChecklistMapping.extract_collection(response.body, :read) }
      end

      # GET /transactions/:transaction_id/checklists/:checklist_id
      action :find do
        verb :get
        path "#{Brokermint.configuration.path_url}/transactions/:transaction_id/checklists/:checklist_id"
        handler(200) { |response| TransactionChecklistMapping.extract_single(response.body, :read) }
      end

    end

  end
end
