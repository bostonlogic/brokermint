require 'faraday'

module Brokermint

  class Client

    attr_reader :api_key

    def initialize(api_key)
      @api_key = api_key
    end

    def connection
      @faraday ||= Faraday.new connection_options do |req|
        req.adapter :net_http
      end
    end

    def resources
      @resources ||= {}
    end

    def self.resources
      {
        contacts: ContactResource,
        incoming_transactions: IncomingTransactionResource,
        reports: ReportResource,
        transaction_backups: TransactionBackupResource,
        transaction_checklists: TransactionChecklistResource,
        transaction_commissions: TransactionCommissionResource,
        transaction_documents: TransactionDocumentResource,
        transaction_notes: TransactionNoteResource,
        transaction_participants: TransactionParticipantResource,
        transaction_tasks: TransactionTaskResource,
        transactions: TransactionResource,
        users: UserResource
      }
    end

    def method_missing(name, *args, &block)
      if self.class.resources.keys.include?(name)
        resources[name] ||= self.class.resources[name].new(connection: connection)
        resources[name]
      else
        super
      end
    end

    private

    def connection_options
      {
        url: Brokermint.configuration.api_url,
        headers: {
          content_type: 'application/json'
        }
      }
    end

  end

end
