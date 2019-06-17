# Create: POST https://my.brokermint.com/api/v1/transactions/<transaction-id>/documents
# Show: GET https://my.brokermint.com/api/v1/transactions/<transaction-id>/documents/<document-upload-request-id>

module Brokermint
  class TransactionDocumentResource < ResourceKit::Resource
    include ErrorHandlingResourcable

    resources do

      # POST /transactions/:transaction_id/documents
      action :create do
        verb :post
        path "#{Brokermint.configuration.path_url}/transactions/:transaction_id/documents"
        handler(200) { |response| TransactionDocumentMapping.extract_single(response.body, :created) }
      end

      # GET /transactions/:transaction_id/documents/:document_upload_request_id
      action :find do
        verb :get
        path "#{Brokermint.configuration.path_url}/transactions/:transaction_id/documents/:document_id"
        handler(200) { |response| TransactionDocumentMapping.extract_single(response.body, :read) }
      end

    end

  end
end
