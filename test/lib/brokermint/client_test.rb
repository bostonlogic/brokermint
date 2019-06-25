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

    def test_connection_sets_the_correct_url
      brokermint_client = Brokermint::Client.new('alohomora')

      assert_equal 'https://my.brokermint.com/', brokermint_client.connection.url_prefix.to_s
    end

    def test_connection_builds_the_correct_headers
      brokermint_client = Brokermint::Client.new('alohomora')

      assert_equal 'application/json', brokermint_client.connection.headers[:content_type]
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
      brokermint_client = Brokermint::Client.new('alohomora')

      assert_raises(NoMethodError) { brokermint_client.not_a_thing }
    end

    def test_client_has_expected_valuea_for_connection
      assert_equal 'application/json', @brokermint_client.connection.headers['Content-Type']
      assert_equal({'api_key'=>'alohomora'}, @brokermint_client.connection.params)
    end

  end

end
