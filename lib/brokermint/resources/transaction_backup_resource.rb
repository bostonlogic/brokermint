module Brokermint
  class TransactionBackupResource < ResourceKit::Resource
    include ErrorHandlingResourcable

    resources do

      # GET /backups
      action :all do
        verb :get
        query_keys :completed_since, :exclude_backup_ids
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
