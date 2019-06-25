require 'test_helper'

class Brokermint::TransactionTaskResourceTest < Minitest::Test

  class All < Minitest::Test

    def setup
      stub_request(:get, 'https://my.brokermint.com/api/v1/transactions/1234/checklists/1234/tasks').
        with(query: {api_key: 'alohomora'}).
        to_return(status: 200, body: api_fixture('transaction_tasks/all'))
      connection = Brokermint::Client.new('alohomora').connection
      resource = Brokermint::TransactionTaskResource.new(connection: connection)

      @transaction_tasks = resource.all(transaction_id: 1234, checklist_id: 1234)
    end

    def test_returns_an_array_of_transactions
      assert_instance_of Array, @transaction_tasks
      assert_equal 2, @transaction_tasks.size
      @transaction_tasks.each{ |transaction_task| assert_instance_of Brokermint::TransactionTask, transaction_task }
    end

    def test_returns_an_array_of_transactions
      assert_equal 1234, @transaction_tasks.first.id
      assert_equal 'Listing agreement', @transaction_tasks.first.name
      assert_equal 'Sign listing agrement with the client', @transaction_tasks.first.description
      assert_equal true, @transaction_tasks.first.document_required
      assert_equal true, @transaction_tasks.first.done
      assert_equal 1386403200000, @transaction_tasks.first.deadline
      @transaction_tasks.first.comments.each{ |comment| assert_instance_of Brokermint::Comment, comment }
      assert_equal 1388127044996, @transaction_tasks.first.created_at
      assert_equal 1390984177675, @transaction_tasks.first.updated_at
      assert_nil @transaction_tasks.first.exemption
      assert_equal 1396599390310, @transaction_tasks.first.submitted_at
      assert_equal 16, @transaction_tasks.first.document_id

      assert_equal 5678, @transaction_tasks.last.id
      assert_equal 'Contact inspection company', @transaction_tasks.last.name
      assert_nil @transaction_tasks.last.description
      assert_equal false, @transaction_tasks.last.document_required
      assert_equal false, @transaction_tasks.last.done
      assert_equal 1402210800000, @transaction_tasks.last.deadline
      assert_equal [], @transaction_tasks.last.comments
      assert_equal 1388394273832, @transaction_tasks.last.created_at
      assert_equal 1402189383407, @transaction_tasks.last.updated_at
      assert_nil @transaction_tasks.last.exemption
      assert_nil @transaction_tasks.last.submitted_at
      assert_nil @transaction_tasks.last.document_id
    end

  end

  class Find < Minitest::Test

    def test_maps_a_transaction_task
      stub_request(:get, 'https://my.brokermint.com/api/v1/transactions/1234/checklists/1234/tasks/1234').
        with(query: {api_key: 'alohomora'}).
        to_return(status: 200, body: api_fixture('transaction_tasks/1234'))
      connection = Brokermint::Client.new('alohomora').connection
      resource = Brokermint::TransactionTaskResource.new(connection: connection)

      transaction_task = resource.find(transaction_id: 1234, checklist_id: 1234, task_id: 1234)

      assert_instance_of Brokermint::TransactionTask, transaction_task
      assert_equal 1234, transaction_task.id
      assert_equal 'Contact inspection company', transaction_task.name
      assert_nil transaction_task.description
      assert_equal false, transaction_task.document_required
      assert_equal false, transaction_task.done
      assert_equal 1402210800000, transaction_task.deadline
      assert_equal [], transaction_task.comments
      assert_equal 1388394273832, transaction_task.created_at
      assert_equal 1402189383407, transaction_task.updated_at
      assert_nil transaction_task.exemption
      assert_nil transaction_task.submitted_at
      assert_nil transaction_task.document_id
    end

    def test_maps_a_transaction_task_with_comments
      stub_request(:get, 'https://my.brokermint.com/api/v1/transactions/1234/checklists/1234/tasks/5678').
        with(query: {api_key: 'alohomora'}).
        to_return(status: 200, body: api_fixture('transaction_tasks/5678'))
      connection = Brokermint::Client.new('alohomora').connection
      resource = Brokermint::TransactionTaskResource.new(connection: connection)

      transaction_task = resource.find(transaction_id: 1234, checklist_id: 1234, task_id: 5678)

      assert_instance_of Brokermint::TransactionTask, transaction_task
      assert_equal 5678, transaction_task.id
      assert_equal 'Listing agreement', transaction_task.name
      assert_equal 'Sign listing agrement with the client', transaction_task.description
      assert_equal true, transaction_task.document_required
      assert_equal true, transaction_task.done
      assert_equal 1386403200000, transaction_task.deadline
      transaction_task.comments.each{ |comment| assert_instance_of Brokermint::Comment, comment }
      assert_equal 1388127044996, transaction_task.created_at
      assert_equal 1390984177675, transaction_task.updated_at
      assert_nil transaction_task.exemption
      assert_equal 1396599390310, transaction_task.submitted_at
      assert_equal 16, transaction_task.document_id
    end

    def test_maps_comments_associatted_with_a_transaction_task
      stub_request(:get, 'https://my.brokermint.com/api/v1/transactions/1234/checklists/1234/tasks/5678').
        with(query: {api_key: 'alohomora'}).
        to_return(status: 200, body: api_fixture('transaction_tasks/5678'))
      connection = Brokermint::Client.new('alohomora').connection
      resource = Brokermint::TransactionTaskResource.new(connection: connection)

      transaction_task = resource.find(transaction_id: 1234, checklist_id: 1234, task_id: 5678)

      assert_equal 2, transaction_task.comments.size

      assert_equal 1389571395834, transaction_task.comments.first.created_at
      assert_equal 'Called client, left voice mail', transaction_task.comments.first.text
      assert_equal 'John Pushdo', transaction_task.comments.first.author

      assert_equal 1389571395137, transaction_task.comments.last.created_at
      assert_equal 'Client called me back, agreed to meet tomorrow and sign the agreement', transaction_task.comments.last.text
      assert_equal 'John Pushdo', transaction_task.comments.last.author
    end

  end

  class Create < Minitest::Test
    def test_creates_and_returns_a_transaction_task
      brokermint_transaction_task = Brokermint::TransactionTask.new(
        name: 'Gin and Tonic',
        description: 'Gin, Tonic, Ice, and Lime Slice',
        document_required: true,
        done: false,
        deadline: 1386403200000,
        exemption: false,
        document_id: 1234
      )
      stub_request(:post, 'https://my.brokermint.com/api/v1/transactions/1234/checklists/1234/tasks').
        with(query: {api_key: 'alohomora'}, body: Brokermint::TransactionTaskMapping.representation_for(:create, brokermint_transaction_task)).
        to_return(status: 200, body: api_fixture('transaction_tasks/9012'))
      connection = Brokermint::Client.new('alohomora').connection
      resource = Brokermint::TransactionTaskResource.new(connection: connection)

      transaction_task = resource.create(brokermint_transaction_task, transaction_id: 1234, checklist_id: 1234)

      assert_instance_of Brokermint::TransactionTask, transaction_task
      assert_equal 9012, transaction_task.id
      assert_equal 'Gin and Tonic', transaction_task.name
      assert_equal 'Gin, Tonic, Ice, and Lime Slice', transaction_task.description
      assert_equal true, transaction_task.document_required
      assert_equal true, transaction_task.done
      assert_equal 1386403200000, transaction_task.deadline
      assert_nil transaction_task.exemption
      assert_equal 1234, transaction_task.document_id
      assert_equal [], transaction_task.comments
    end
  end

  class Update < Minitest::Test
    def test_updates_and_returns_a_transaction
      brokermint_transaction = Brokermint::TransactionTask.new(
        external_id: 'Gin and Bitter Lemon',
        description: 'Gin, Bitter Lemon, Ice. Garnish with a Lemon slice and Lime Slice',
        comments: [Brokermint::Comment.new(text: 'Lily had the right idea', author: 'Ginny Weasley')]
      )
      stub_request(:put, 'https://my.brokermint.com/api/v1/transactions/1234/checklists/1234/tasks/9012').
        with(query: {api_key: 'alohomora'}, body: "{\"description\":\"Gin, Bitter Lemon, Ice. Garnish with a Lemon slice and Lime Slice\",\"comments\":[{\"text\":\"Lily had the right idea\",\"author\":\"Ginny Weasley\",\"author_id\":null}]}").
        to_return(status: 200, body: api_fixture('transaction_tasks/9012_updated'))
      connection = Brokermint::Client.new('alohomora').connection
      resource = Brokermint::TransactionTaskResource.new(connection: connection)

      transaction_task = resource.update(brokermint_transaction, transaction_id: 1234, checklist_id: 1234, task_id: 9012)

      assert_instance_of Brokermint::TransactionTask, transaction_task

      assert_equal 9012, transaction_task.id
      assert_equal 'Gin and Bitter Lemon', transaction_task.name
      assert_equal 'Gin, Bitter Lemon, Ice. Garnish with a Lemon slice and Lime Slice', transaction_task.description
      assert_equal [], transaction_task.comments
    end
  end

  class ReviewSubmit < Minitest::Test
    def test_returns_true_for_a_destroy_response
      skip('Unsure of what is required for this endpoint')
      stub_request(:post, 'https://my.brokermint.com/api/v1/transactions/1234/checklists/1234/tasks/9012/submit_document').
        with(query: {api_key: 'alohomora'}).
        to_return(status: 200, body: '')
      connection = Brokermint::Client.new('alohomora').connection
      resource = Brokermint::TransactionTaskResource.new(connection: connection)

      transaction_task = resource.destroy(transaction_id: 1234)

      assert_equal true, transaction_task
    end
  end

end
