# List: GET https://my.brokermint.com/api/v1/transactions/<transaction-id>/checklists/<checklist-id>/tasks
# Show: GET https://my.brokermint.com/api/v1/transactions/<transaction-id>/checklists/<checklist-id>/tasks/<task-id>
# Create: POST https://my.brokermint.com/api/v1/transactions/<transaction-id>/checklists/<checklist-id>/tasks
# Update: PUT https://my.brokermint.com/api/v1/transactions/<transaction-id>/checklists/<checklist-id>/tasks/<task-id>
# Submit for review: POST https://my.brokermint.com/api/v1/transactions/<transaction-id>/checklists/<checklist-id>/tasks/<task-id>/submit_document

module Brokermint
  class TransactionTaskResource < ResourceKit::Resource
    include ErrorHandlingResourcable

    resources do
      # GET /transactions/:transaction_id/checklists/:checklist_id/tasks
      action :all do
        verb :get
        path "#{Brokermint.configuration.path_url}/transactions/:transaction_id/checklists/:checklist_id/tasks"
        handler(200) { |response| TransactionTaskMapping.extract_collection(response.body, :read) }
      end

      # GET /transactions/:transaction_id/checklists/:checklist_id/tasks/:task_id
      action :find do
        verb :get
        path "#{Brokermint.configuration.path_url}/transactions/:transaction_id/checklists/:checklist_id/tasks/:task_id"
        handler(200) { |response| TransactionTaskMapping.extract_single(response.body, :read) }
      end

      # POST /transactions/:transaction_id/checklists/:checklist_id/tasks
      action :create do
        verb :post
        body { |object| TransactionTaskMapping.representation_for(:create, object) }
        path "#{Brokermint.configuration.path_url}/transactions/:transaction_id/checklists/:checklist_id/tasks"
        handler(200) { |response| TransactionTaskMapping.extract_single(response.body, :read) }
      end

      # PUT /transactions/:transaction_id/checklists/:checklist_id/tasks/:task_id
      action :update do
        verb :put
        body { |object| TransactionTaskMapping.hash_for(:update, object).select{ |_, value| !value.nil? }.to_json }
        path "#{Brokermint.configuration.path_url}/transactions/:transaction_id/checklists/:checklist_id/tasks/:task_id"
        handler(200) { |response| TransactionTaskMapping.extract_single(response.body, :read) }
      end

      # POST /transactions/:transaction_id/checklists/:checklist_id/tasks/:task_id/submit_document
      action :review_submit do
        verb :post
        path "#{Brokermint.configuration.path_url}/transactions/:transaction_id/checklists/:checklist_id/tasks/:task_id/submit_document"
        handler(200) { |response| TransactionTaskMapping.extract_single(response.body, :read) }
      end

    end

  end
end
