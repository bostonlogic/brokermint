require 'test_helper'

class Brokermint::ClientTest < Minitest::Test

  class Initialize < Minitest::Test

    def test_initialize_requires_an_access_token
      assert_raises(ArgumentError) { Brokermint::Client.new }
    end

    def test_initialize_creates_a_brokermint_client_instance
      brokermint_client = Brokermint::Client.new('alohomora')

      assert_instance_of Brokermint::Client, brokermint_client
    end

    def test_initialize_sets_the_provided_access_token
      brokermint_client = Brokermint::Client.new('alohomora')

      assert_equal 'alohomora', brokermint_client.api_key
    end

  end

  class Connection < Minitest::Test

    def setup
      @brokermint_client = Brokermint::Client.new('alohomora')
    end

    def test_connection_sets_the_correct_url
      assert_equal 'https://my.brokermint.com/', @brokermint_client.connection.url_prefix.to_s
    end

    def test_connection_builds_the_correct_headers
      assert_equal 'application/json', @brokermint_client.connection.headers[:content_type]
    end

    def test_connection_builds_the_correct_default_query_params
      assert_equal({'api_key'=>'alohomora'}, @brokermint_client.connection.params)
    end

  end

  class EndpointHandling < Minitest::Test

    def setup
      @brokermint_client = Brokermint::Client.new('alohomora')
    end

    {
      :contacts                 => Brokermint::ContactResource,
      :incoming_transactions    => Brokermint::IncomingTransactionResource,
      :reports                  => Brokermint::ReportResource,
      :transaction_backups      => Brokermint::TransactionBackupResource,
      :transaction_checklists   => Brokermint::TransactionChecklistResource,
      :transaction_commissions  => Brokermint::TransactionCommissionResource,
      :transaction_documents    => Brokermint::TransactionDocumentResource,
      :transaction_notes        => Brokermint::TransactionNoteResource,
      :transaction_participants => Brokermint::TransactionParticipantResource,
      :transaction_tasks        => Brokermint::TransactionTaskResource,
      :transactions             => Brokermint::TransactionResource,
      :users                    => Brokermint::UserResource
    }.each do |method, result|
      define_method "test_#{method}_returns_#{result}" do
        assert_instance_of result, @brokermint_client.send(method)
      end
    end

    def test_invalid_endpoints_raise_method_missing_error
      assert_raises(NoMethodError) { @brokermint_client.not_a_thing }
    end

    def test_contacts_all_endpoint_works_as_expected
      stub_request(:get, 'https://my.brokermint.com/api/v1/contacts').
        with(query: {api_key: 'alohomora', created_since: '2019-06-19', updated_since: '2019-06-19', external_ids: '1,2,3,4,5', full_info: 1}).
        to_return(status: 200, body: api_fixture('contacts/all'))

      contacts = @brokermint_client.contacts.all(created_since: '2019-06-19', updated_since: '2019-06-19', external_ids: '1,2,3,4,5', full_info: 1)

      assert_instance_of Array, contacts
      contacts.each{ |contact| assert_instance_of Brokermint::Contact, contact }
    end

    def test_reports_all_endpoint_works_as_expected
      stub_request(:get, 'https://my.brokermint.com/api/v1/reports').
        with(query: {api_key: 'alohomora'}).
        to_return(status: 200, body: api_fixture('reports/all'))

      reports = @brokermint_client.reports.all(created_since: '2019-06-19', updated_since: '2019-06-19', external_ids: '1,2,3,4,5', full_info: 1)

      assert_instance_of Array, reports
      reports.each{ |report| assert_instance_of Brokermint::Report, report }
    end

    def test_transaction_backups_all_endpoint_works_as_expected
      stub_request(:get, 'https://my.brokermint.com/api/v1/backups').
        with(query: {api_key: 'alohomora', completed_since: '2019-06-19', exclude_backup_ids: '2019-06-19'}).
        to_return(status: 200, body: api_fixture('transaction_backups/all'))

      transaction_backups = @brokermint_client.transaction_backups.all(completed_since: '2019-06-19', exclude_backup_ids: '2019-06-19', random_query_param: '1,2,3,4,5', full_info: 1)

      assert_instance_of Array, transaction_backups
      transaction_backups.each{ |transaction_backup| assert_instance_of Brokermint::TransactionBackup, transaction_backup }
    end

    def test_transaction_checklists_all_endpoint_works_as_expected
      stub_request(:get, 'https://my.brokermint.com/api/v1/transactions/1234/checklists').
        with(query: {api_key: 'alohomora'}).
        to_return(status: 200, body: api_fixture('transaction_checklists/all'))

      transaction_checklists = @brokermint_client.transaction_checklists.all(transaction_id: '1234', random_query_param: '1,2,3,4,5')

      assert_instance_of Array, transaction_checklists
      transaction_checklists.each{ |transaction_checklist| assert_instance_of Brokermint::TransactionChecklist, transaction_checklist }
    end

    def test_transaction_commissions_all_endpoint_works_as_expected
      stub_request(:get, 'https://my.brokermint.com/api/v1/transactions/1234/commissions').
        with(query: {api_key: 'alohomora'}).
        to_return(status: 200, body: api_fixture('transaction_commissions/all'))

      transaction_commissions = @brokermint_client.transaction_commissions.all(transaction_id: '1234', random_query_param: '1,2,3,4,5')

      assert_instance_of Array, transaction_commissions
      transaction_commissions.each{ |transaction_commission| assert_instance_of Brokermint::TransactionCommission, transaction_commission }
    end

    def test_transaction_participants_all_endpoint_works_as_expected
      stub_request(:get, 'https://my.brokermint.com/api/v1/transactions/1234/participants').
        with(query: {api_key: 'alohomora'}).
        to_return(status: 200, body: api_fixture('transaction_participants/all'))

      transaction_participants = @brokermint_client.transaction_participants.all(transaction_id: '1234', random_query_param: '1,2,3,4,5')

      assert_instance_of Array, transaction_participants
      transaction_participants.each{ |transaction_participant| assert_instance_of Brokermint::TransactionParticipant, transaction_participant }
    end

    def test_transaction_tasks_all_endpoint_works_as_expected
      stub_request(:get, 'https://my.brokermint.com/api/v1/transactions/1234/checklists/1234/tasks').
        with(query: {api_key: 'alohomora'}).
        to_return(status: 200, body: api_fixture('transaction_tasks/all'))

      transaction_tasks = @brokermint_client.transaction_tasks.all(transaction_id: '1234', checklist_id: 1234, random_query_param: '1,2,3,4,5')

      assert_instance_of Array, transaction_tasks
      transaction_tasks.each{ |transaction_task| assert_instance_of Brokermint::TransactionTask, transaction_task }
    end

    def test_transactions_all_endpoint_works_as_expected
      stub_request(:get, "https://my.brokermint.com/api/v1/transactions").
        with(query: {api_key: 'alohomora', statuses: 'listing,pending', created_since: '2019-06-19', updated_since: '2019-06-19', closed_since: '2019-06-19', owned_by: 'User-1234', external_ids: '1,2,3,4,5', full_info: 1}).
        to_return(status: 200, body: api_fixture('transactions/all'))

      transactions = @brokermint_client.transactions.all(statuses: 'listing,pending', created_since: '2019-06-19', updated_since: '2019-06-19', closed_since: '2019-06-19', owned_by: 'User-1234', external_ids: '1,2,3,4,5', full_info: 1)

      assert_instance_of Array, transactions
      transactions.each{ |transaction| assert_instance_of Brokermint::Transaction, transaction }
    end

    def test_users_all_endpoint_works_as_expected
      stub_request(:get, "https://my.brokermint.com/api/v1/users").
        with(query: {api_key: 'alohomora', created_since: '2019-06-19', updated_since: '2019-06-19', external_ids: '1,2,3,4,5', full_info: 1}).
        to_return(status: 200, body: api_fixture('users/all'))

      users = @brokermint_client.users.all(created_since: '2019-06-19', updated_since: '2019-06-19', external_ids: '1,2,3,4,5', full_info: 1)

      assert_instance_of Array, users
      users.each{ |user| assert_instance_of Brokermint::User, user }
    end

  end

end
