# List: GET https://my.brokermint.com/api/v1/backups
# Show: GET https://my.brokermint.com/api/v1/transactions/<transaction-id>/backup

module Brokermint
  class TransactionBackupResource < ResourceKit::Resource
    include ErrorHandlingResourcable

    resources do

      # GET /backups
      action :all do
        verb :get
        path "#{Brokermint.configuration.path_url}/backups"
        handler(200) { |response| TransactionBackupMapping.extract_collection(response.body, :all) }
      end

      # GET /transactions/:transaction_id/backup
      action :find do
        verb :get
        path "#{Brokermint.configuration.path_url}transactions/:transaction_id/backup"
        handler(200) { |response| TransactionBackupMapping.extract_single(response.body, :read) }
      end

    end

  end
end
