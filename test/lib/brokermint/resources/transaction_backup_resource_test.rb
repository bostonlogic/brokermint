require 'test_helper'

class Brokermint::TransactionBackupResourceTest < Minitest::Test

  class All < Minitest::Test

    def setup
      stub_request(:get, 'https://my.brokermint.com/api/v1/backups').
        with(query: {api_key: 'alohomora'}).
        to_return(status: 200, body: api_fixture('transaction_backups/all'))

      connection = Brokermint::Client.new('alohomora').connection
      resource = Brokermint::TransactionBackupResource.new(connection: connection)

      @transaction_backups = resource.all
    end

    def test_returns_an_arry_of_backups
      assert_instance_of Array, @transaction_backups
      @transaction_backups.each{ |transaction_backup| assert_instance_of Brokermint::TransactionBackup, transaction_backup }
    end

    def test_maps_the_arry_of_backups
      assert_equal 1234, @transaction_backups.first.id
      assert_equal 1429147920000, @transaction_backups.first.completed_at
      assert_equal '3998_Indiana_St,_Carlton,_MA,_90210.zip', @transaction_backups.first.file_name
      assert_equal 'https://s3-eu-central-1.amazonaws.com/BUCKET/FILE', @transaction_backups.first.link
    end

  end

  class Find < Minitest::Test

    def test_returns_a_backup
      stub_request(:get, 'https://my.brokermint.com/api/v1transactions/1234/backup').
        with(query: {api_key: 'alohomora'}).
        to_return(status: 200, body: api_fixture('transaction_backups/1234'))

      connection = Brokermint::Client.new('alohomora').connection
      resource = Brokermint::TransactionBackupResource.new(connection: connection)

      transaction_backup = resource.find(transaction_id: 1234)

      assert_equal 'https://s3-eu-central-1.amazonaws.com/BUCKET/FILE', transaction_backup.link
    end

  end

end
