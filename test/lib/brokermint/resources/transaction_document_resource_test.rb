require 'test_helper'

class Brokermint::TransactionDocumentResourceTest < Minitest::Test

  class Create < Minitest::Test

    def test_creates_and_returns_a_document_id
      stub_request(:post, 'https://my.brokermint.com/api/v1/transactions/1234/documents').
        to_return(status: 200, body: api_fixture('transaction_documents/create'))

      connection = Brokermint::Client.new('access_token').connection
      resource = Brokermint::TransactionDocumentResource.new(connection: connection)

      transaction_document = resource.create(transaction_id: 1234)

      assert_instance_of Brokermint::TransactionDocument, transaction_document

      assert_equal 1234, transaction_document.id
    end

  end

  class Find < Minitest::Test

    def test_returns_and_maps_a_document_in_processing_upload_status
      stub_request(:get, 'https://my.brokermint.com/api/v1/transactions/1234/documents/1234').
        to_return(status: 200, body: api_fixture('transaction_documents/1234'))

      connection = Brokermint::Client.new('access_token').connection
      resource = Brokermint::TransactionDocumentResource.new(connection: connection)

      transaction_document = resource.find(transaction_id: 1234, document_id: 1234)

      assert_instance_of Brokermint::TransactionDocument, transaction_document

      assert_equal 1234, transaction_document.id
      assert_equal 'Nimbus 2000.pdf', transaction_document.name
      assert_equal 'processing', transaction_document.upload_status
      assert_nil transaction_document.url
    end

    def test_returns_and_maps_a_document_in_completed_upload_status
      stub_request(:get, 'https://my.brokermint.com/api/v1/transactions/1234/documents/5678').
        to_return(status: 200, body: api_fixture('transaction_documents/5678'))

      connection = Brokermint::Client.new('access_token').connection
      resource = Brokermint::TransactionDocumentResource.new(connection: connection)

      transaction_document = resource.find(transaction_id: 1234, document_id: 5678)

      assert_instance_of Brokermint::TransactionDocument, transaction_document

      assert_equal 5678, transaction_document.id
      assert_equal 'Firebolt.pdf', transaction_document.name
      assert_equal 'complete', transaction_document.upload_status
      assert_equal 'https://www.toyota.com/content/ebrochure/2020/sienna_ebrochure.pdf', transaction_document.url
    end

  end

end
