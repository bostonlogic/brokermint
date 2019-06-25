require 'test_helper'

class Brokermint::IncomingTransactionResourceTest < Minitest::Test

  class Create < Minitest::Test

    def setup
      incoming_transaction = Brokermint::IncomingTransaction.new(
        source_id: 'Homespotter.com',
        transactions: [
          Brokermint::TransactionAttribute.new(
            id: 72643545,
        	  address: "399 Marlborough, #9",
        	  city: "Boston",
        	  state: "MA",
        	  zip: "02115",
        	  status: "Active",
        	  price: 1595,
        	  transaction_type: "Rental",
        	  custom_attributes: Brokermint::CustomTransactionAttribute.new(
        	  	bedrooms: 0,
        	  	total_baths: 1,
        	  	legal_description: "Super cute studio unit",
        	  	property_type: "Rental - Apartment",
        	  	mls_number: 72504177
        	  )
          ),
          Brokermint::TransactionAttribute.new(
            id: 72645568,
        	  address: "399 Marlborough, #13",
        	  city: "Boston",
        	  state: "MA",
        	  zip: "02115",
        	  status: "Active",
        	  price: 1595,
        	  transaction_type: "Rental",
        	  custom_attributes: Brokermint::CustomTransactionAttribute.new(
        	  	bedrooms: 0,
        	  	total_baths: 1,
        	  	legal_description: "Super cute sunny studio",
        	  	property_type: "Rental - Apartment",
        	  	mls_number: 72504214
        	  )
          ),
          Brokermint::TransactionAttribute.new(
            id: 72647000,
        	  address: "399 Marlborough, #16",
        	  city: "Boston",
        	  state: "MA",
        	  zip: "02115",
        	  status: "Active",
        	  price: 1645,
        	  transaction_type: "Rental",
        	  custom_attributes: Brokermint::CustomTransactionAttribute.new(
        	  	bedrooms: 0,
        	  	total_baths: 1,
        	  	legal_description: "Two big windows overlook Back Bay!",
        	  	property_type: "Rental - Apartment",
        	  	mls_number: 72504235
        	  )
          )
        ]
      )

      stub_request(:post, 'https://my.brokermint.com/api/v1/incoming_transactions').
        with(query: {api_key: 'alohomora'}, body: Brokermint::IncomingTransactionMapping.representation_for(:create, incoming_transaction)).
        to_return(status: 200, body: api_fixture('incoming_transactions/all'))

      connection = Brokermint::Client.new('alohomora').connection
      resource = Brokermint::IncomingTransactionResource.new(connection: connection)

      @incoming_transactions = resource.create(incoming_transaction)
    end

    def test_returns_an_array_of_incoming_transactions
      assert_instance_of Array, @incoming_transactions
      assert_equal 3, @incoming_transactions.size
      @incoming_transactions.each{ |incoming_transaction| assert_instance_of Brokermint::IncomingTransaction, incoming_transaction }
    end

    def test_maps_incoming_transactions_correctly
      assert_equal 1234, @incoming_transactions[0].id
      assert_equal '72643545', @incoming_transactions[0].external_id

      assert_equal 5678, @incoming_transactions[1].id
      assert_equal '72645568', @incoming_transactions[1].external_id

      assert_equal 9012, @incoming_transactions[2].id
      assert_equal '72647000', @incoming_transactions[2].external_id
    end

  end

end
