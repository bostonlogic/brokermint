require 'test_helper'

class Brokermint::TransactionChecklistResourceTest < Minitest::Test

  class All < Minitest::Test

    def setup
      stub_request(:get, 'https://my.brokermint.com/api/v1/transactions/1234/checklists').
        to_return(status: 200, body: api_fixture('transaction_checklists/all'))

      connection = Brokermint::Client.new('access_token').connection
      resource = Brokermint::TransactionChecklistResource.new(connection: connection)

      @transaction_checklists = resource.all(transaction_id: 1234)
    end

    def test_returns_an_arry_of_backups
      assert_instance_of Array, @transaction_checklists
      @transaction_checklists.each{ |transaction_checklist| assert_instance_of Brokermint::TransactionChecklist, transaction_checklist }
    end

    def test_maps_the_arry_of_backups
      assert_equal 1234, @transaction_checklists.first.id
      assert_equal 'Listing checklist', @transaction_checklists.first.name

      assert_equal 5678, @transaction_checklists.last.id
      assert_equal 'Buying checklist', @transaction_checklists.last.name
    end

  end

  class Find < Minitest::Test

    def test_returns_a_backup
      stub_request(:get, 'https://my.brokermint.com/api/v1/transactions/1234/checklists/1234').
        to_return(status: 200, body: api_fixture('transaction_checklists/1234'))

      connection = Brokermint::Client.new('access_token').connection
      resource = Brokermint::TransactionChecklistResource.new(connection: connection)

      transaction_checklist = resource.find(transaction_id: 1234, checklist_id: 1234)

      assert_equal 1234, transaction_checklist.id
      assert_equal 'Listing checklist', transaction_checklist.name
    end

  end

end
