require 'test_helper'

class Brokermint::ContactResourceTest < Minitest::Test

  class All < Minitest::Test
    def test_returns_an_array_of_transactions
      stub_request(:get, "https://my.brokermint.com/api/v1/transactions").
        with(query: {api_key: 'alohomora'}).
        to_return(status: 200, body: api_fixture('transactions/all'))
      connection = Brokermint::Client.new('alohomora').connection
      resource = Brokermint::TransactionResource.new(connection: connection)

      transactions = resource.all

      assert_instance_of Array, transactions
      transactions.each{ |transaction| assert_instance_of Brokermint::Transaction, transaction }
    end
  end

  class Find < Minitest::Test

    def test_returns_a_transaction
      stub_request(:get, "https://my.brokermint.com/api/v1/transactions/1234").
        with(query: {api_key: 'alohomora'}).
        to_return(status: 200, body: api_fixture('transactions/1234'))
      connection = Brokermint::Client.new('alohomora').connection
      resource = Brokermint::TransactionResource.new(connection: connection)

      transaction = resource.find(transaction_id: 1234)

      assert_instance_of Brokermint::Transaction, transaction
      assert_equal 1234, transaction.id
      assert_equal '146 Aldon Drive', transaction.address
      assert_equal 'Chester', transaction.city
      assert_equal 'CA', transaction.state
      assert_equal '96020', transaction.zip
      assert_equal 'listing', transaction.status
      assert_equal 205000, transaction.price
      assert_equal 'traditional sale', transaction.transaction_type
      assert_equal 'seller', transaction.representing
      assert_nil transaction.acceptance_date
      assert_nil transaction.expiration_date
      assert_equal 1559603744941, transaction.created_at
      assert_equal 1559603745288, transaction.updated_at
      assert_nil transaction.closing_date
      assert_equal 10250, transaction.total_gross_commission
      assert_nil transaction.listing_date
      assert_nil transaction.external_id
      assert_nil transaction.timezone
      assert_nil transaction.commissions_finalized_at
      assert_equal 'TR-2019-640224', transaction.custom_id
      assert_nil transaction.closed_at
      transaction.custom_attributes.each{ |custom_attribute| assert_instance_of Brokermint::CustomAttribute, custom_attribute }
      assert_nil transaction.buying_side_representer
      assert_instance_of Brokermint::Representer, transaction.listing_side_representer
    end

    def test_returns_custom_attributes_associated_with_a_transaction
      stub_request(:get, "https://my.brokermint.com/api/v1/transactions/1234").
        with(query: {api_key: 'alohomora'}).
        to_return(status: 200, body: api_fixture('transactions/1234'))
      connection = Brokermint::Client.new('alohomora').connection
      resource = Brokermint::TransactionResource.new(connection: connection)

      transaction = resource.find(transaction_id: 1234)

      assert_instance_of Brokermint::Transaction, transaction
      assert_equal 3, transaction.custom_attributes.size
      assert_equal 'text', transaction.custom_attributes.first.type
      assert_equal 'MLS #', transaction.custom_attributes.first.label
      assert_equal 'mls_number', transaction.custom_attributes.first.name
      assert_nil transaction.custom_attributes.first.value
      assert_equal 'dropdown', transaction.custom_attributes[1].type
      assert_equal 'Lead source', transaction.custom_attributes[1].label
      assert_equal 'lead_source', transaction.custom_attributes[1].name
      assert_nil transaction.custom_attributes[1].value
      assert_equal 'text', transaction.custom_attributes.last.type
      assert_equal 'County', transaction.custom_attributes.last.label
      assert_equal 'county', transaction.custom_attributes.last.name
      assert_nil transaction.custom_attributes.last.value
    end

    def test_returns_valid_representer_for_a_transaction
      stub_request(:get, "https://my.brokermint.com/api/v1/transactions/1234").
        with(query: {api_key: 'alohomora'}).
        to_return(status: 200, body: api_fixture('transactions/1234'))
      connection = Brokermint::Client.new('alohomora').connection
      resource = Brokermint::TransactionResource.new(connection: connection)

      transaction = resource.find(transaction_id: 1234)

      assert_instance_of Brokermint::Transaction, transaction
      assert_equal 8930, transaction.listing_side_representer.id
      assert_equal 'Account', transaction.listing_side_representer.type
    end

  end

  class Create < Minitest::Test
    def test_creates_and_returns_a_transaction
      brokermint_transaction = Brokermint::Transaction.new(
        external_id: 'TEST-ID1',
        address: '146 Aldon Drive',
        city: 'Chester',
        state: 'CA',
        zip: '96020',
        status: 'listed',
        transaction_type: 'traditional sale',
        price: 205000,
        representing: 'buyer',
        total_gross_commission: 6,
        listing_date: 1549564698000,
        buying_side_representer: Brokermint::Representer.new(
          id: 44765,
          type: 'Account'
        ),
        timezone: -4
      )
      stub_request(:post, "https://my.brokermint.com/api/v1/transactions").
        with(query: {api_key: 'alohomora'}, body: Brokermint::TransactionMapping.representation_for(:create, brokermint_transaction)).
        to_return(status: 201, body: api_fixture('transactions/1234'))
      connection = Brokermint::Client.new('alohomora').connection
      resource = Brokermint::TransactionResource.new(connection: connection)

      transaction = resource.create(brokermint_transaction)

      assert_instance_of Brokermint::Transaction, transaction
      assert_equal 1234, transaction.id
      assert_equal '146 Aldon Drive', transaction.address
      assert_equal 'Chester', transaction.city
      assert_equal 'CA', transaction.state
      assert_equal '96020', transaction.zip
      assert_equal 'listing', transaction.status
      assert_equal 205000, transaction.price
      assert_equal 'traditional sale', transaction.transaction_type
      assert_equal 'seller', transaction.representing
      assert_nil transaction.acceptance_date
      assert_nil transaction.expiration_date
      assert_equal 1559603744941, transaction.created_at
      assert_equal 1559603745288, transaction.updated_at
      assert_nil transaction.closing_date
      assert_equal 10250, transaction.total_gross_commission
      assert_nil transaction.listing_date
      assert_nil transaction.external_id
      assert_nil transaction.timezone
      assert_nil transaction.commissions_finalized_at
      assert_equal 'TR-2019-640224', transaction.custom_id
      assert_nil transaction.closed_at
      transaction.custom_attributes.each{ |custom_attribute| assert_instance_of Brokermint::CustomAttribute, custom_attribute }
      assert_nil transaction.buying_side_representer
      assert_instance_of Brokermint::Representer, transaction.listing_side_representer
    end
  end

  class Update < Minitest::Test
    def test_updates_and_returns_a_transaction
      brokermint_transaction = Brokermint::Transaction.new(
        external_id: 'TEST-ID1',
        city: 'Chester',
        state: 'CA',
        status: 'listed'
      )
      stub_request(:put, "https://my.brokermint.com/api/v1/transactions/1234").
        with(query: {api_key: 'alohomora'}, body: "{\"city\":\"Chester\",\"state\":\"CA\",\"status\":\"listed\",\"external_id\":\"TEST-ID1\",\"custom_attributes\":[]}").
        to_return(status: 200, body: api_fixture('transactions/1234'))
      connection = Brokermint::Client.new('alohomora').connection
      resource = Brokermint::TransactionResource.new(connection: connection)

      transaction = resource.update(brokermint_transaction, transaction_id: 1234)

      assert_instance_of Brokermint::Transaction, transaction
      assert_equal 1234, transaction.id
      assert_equal '146 Aldon Drive', transaction.address
      assert_equal 'Chester', transaction.city
      assert_equal 'CA', transaction.state
      assert_equal '96020', transaction.zip
      assert_equal 'listing', transaction.status
      assert_equal 205000, transaction.price
      assert_equal 'traditional sale', transaction.transaction_type
      assert_equal 'seller', transaction.representing
      assert_nil transaction.acceptance_date
      assert_nil transaction.expiration_date
      assert_equal 1559603744941, transaction.created_at
      assert_equal 1559603745288, transaction.updated_at
      assert_nil transaction.closing_date
      assert_equal 10250, transaction.total_gross_commission
      assert_nil transaction.listing_date
      assert_nil transaction.external_id
      assert_nil transaction.timezone
      assert_nil transaction.commissions_finalized_at
      assert_equal 'TR-2019-640224', transaction.custom_id
      assert_nil transaction.closed_at
      transaction.custom_attributes.each{ |custom_attribute| assert_instance_of Brokermint::CustomAttribute, custom_attribute }
      assert_nil transaction.buying_side_representer
      assert_instance_of Brokermint::Representer, transaction.listing_side_representer
    end
  end

  class Destroy < Minitest::Test
    def test_returns_true_for_a_destroy_response
      stub_request(:delete, "https://my.brokermint.com/api/v1/transactions/1234").
        with(query: {api_key: 'alohomora'}).
        to_return(status: 200, body: '')
      connection = Brokermint::Client.new('alohomora').connection
      resource = Brokermint::TransactionResource.new(connection: connection)

      transaction = resource.destroy(transaction_id: 1234)

      assert_equal true, transaction
    end
  end

end
