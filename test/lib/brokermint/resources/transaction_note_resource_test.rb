require 'test_helper'

class Brokermint::TransactionNoteResourceTest < Minitest::Test

  class Create < Minitest::Test

    def test_creates_a_transaction_note_and_returns_true
      stub_request(:post, 'https://my.brokermint.com/api/v1/transactions/1234/notes').
        with(query: {api_key: 'alohomora'}, body: "{\"text\":\"I had proven, as a very young man, that power was my weakness and temptation. I was safer at Hogwarts. I think I was a good teacher.\"}").
        to_return(status: 200, body: api_fixture('transaction_documents/create'))

      connection = Brokermint::Client.new('alohomora').connection
      resource = Brokermint::TransactionNoteResource.new(connection: connection)
      transaction_note = Brokermint::TransactionNote.new(text: 'I had proven, as a very young man, that power was my weakness and temptation. I was safer at Hogwarts. I think I was a good teacher.')

      transaction_document = resource.create(transaction_note, transaction_id: 1234)

      assert_equal true, transaction_document
    end

  end

end
