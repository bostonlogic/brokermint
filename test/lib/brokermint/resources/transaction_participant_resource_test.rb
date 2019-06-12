require 'test_helper'

class Brokermint::TransactionParticipantResourceTest < Minitest::Test

  class All < Minitest::Test

    def setup
      stub_request(:get, 'https://my.brokermint.com/api/v1/transactions/1234/participants').
        to_return(status: 200, body: api_fixture('transaction_participants/all'))

      connection = Brokermint::Client.new('access_token').connection
      resource = Brokermint::TransactionParticipantResource.new(connection: connection)

      @transaction_participants = resource.all(transaction_id: 1234)
    end

    def test_returns_an_array_of_transaction_participants
      assert_instance_of Array, @transaction_participants
      @transaction_participants.each{ |transaction_participant| assert_instance_of Brokermint::TransactionParticipant, transaction_participant }
    end

    def test_maps_transaction_participants_correctly
      assert_equal 1234, @transaction_participants.first.id
      assert_equal 'transaction owner', @transaction_participants.first.role
      assert_equal 'User', @transaction_participants.first.type
      assert_equal true, @transaction_participants.first.owner
      assert_equal 'minerva.mcgonagall@hogwarts.edu', @transaction_participants.first.email
      assert_equal 'Minerva', @transaction_participants.first.first_name
      assert_equal 'McGonagall', @transaction_participants.first.last_name

      assert_equal 1234, @transaction_participants.last.id
      assert_equal 'Agent', @transaction_participants.last.role
      assert_equal 'Contact', @transaction_participants.last.type
      assert_equal false, @transaction_participants.last.owner
      assert_equal 'angelina.johnson@hogwarts.edu', @transaction_participants.last.email
      assert_equal 'Angelina', @transaction_participants.last.first_name
      assert_equal 'Johnson', @transaction_participants.last.last_name
    end

  end

  class AllContacts < Minitest::Test

    def setup
      stub_request(:get, 'https://my.brokermint.com/api/v1/transactions/1234/participants/contacts').
        to_return(status: 200, body: api_fixture('transaction_participants/contacts'))

      connection = Brokermint::Client.new('access_token').connection
      resource = Brokermint::TransactionParticipantResource.new(connection: connection)

      @transaction_participants = resource.contacts(transaction_id: 1234)
    end

    def test_returns_an_array_of_transaction_participant_contacts
      assert_instance_of Array, @transaction_participants
      @transaction_participants.each{ |transaction_participant| assert_instance_of Brokermint::TransactionParticipant, transaction_participant }
      @transaction_participants.each{ |transaction_participant| assert_equal 'Contact', transaction_participant.type }
    end

    def test_maps_transaction_participant_contact_correctly
      assert_equal 1234, @transaction_participants.last.id
      assert_equal 'Agent', @transaction_participants.last.role
      assert_equal 'Contact', @transaction_participants.last.type
      assert_equal false, @transaction_participants.last.owner
      assert_equal 'angelina.johnson@hogwarts.edu', @transaction_participants.last.email
      assert_equal 'Angelina', @transaction_participants.last.first_name
      assert_equal 'Johnson', @transaction_participants.last.last_name
    end

  end

  class AllUsers < Minitest::Test

    def setup
      stub_request(:get, 'https://my.brokermint.com/api/v1/transactions/1234/participants/users').
        to_return(status: 200, body: api_fixture('transaction_participants/users'))

      connection = Brokermint::Client.new('access_token').connection
      resource = Brokermint::TransactionParticipantResource.new(connection: connection)

      @transaction_participants = resource.users(transaction_id: 1234)
    end

    def test_returns_an_array_of_transaction_participant_users
      assert_instance_of Array, @transaction_participants
      @transaction_participants.each{ |transaction_participant| assert_instance_of Brokermint::TransactionParticipant, transaction_participant }
      @transaction_participants.each{ |transaction_participant| assert_equal 'User', transaction_participant.type }
    end

    def test_maps_transaction_participant_user_correctly
      assert_equal 1234, @transaction_participants.first.id
      assert_equal 'transaction owner', @transaction_participants.first.role
      assert_equal 'User', @transaction_participants.first.type
      assert_equal true, @transaction_participants.first.owner
      assert_equal 'minerva.mcgonagall@hogwarts.edu', @transaction_participants.first.email
      assert_equal 'Minerva', @transaction_participants.first.first_name
      assert_equal 'McGonagall', @transaction_participants.first.last_name
    end

  end

  class Contact < Minitest::Test

    def setup
      stub_request(:get, 'https://my.brokermint.com/api/v1/transactions/1234/participants/contacts/1234').
        to_return(status: 200, body: api_fixture('transaction_participants/contact_1234'))

      connection = Brokermint::Client.new('access_token').connection
      resource = Brokermint::TransactionParticipantResource.new(connection: connection)

      @transaction_participant = resource.contact(transaction_id: 1234, contact_id: 1234)
    end

    def test_returns_a_transaction_participant_contact
      assert_instance_of Brokermint::TransactionParticipant, @transaction_participant
    end

    def test_maps_a_transaction_participant_contact_correctly
      assert_equal 1234, @transaction_participant.id
      assert_equal 'Agent', @transaction_participant.role
      assert_equal 'Contact', @transaction_participant.type
      assert_equal false, @transaction_participant.owner
      assert_equal 'angelina.johnson@hogwarts.edu', @transaction_participant.email
      assert_equal 'Angelina', @transaction_participant.first_name
      assert_equal 'Johnson', @transaction_participant.last_name
    end

  end

  class User < Minitest::Test

    def setup
      stub_request(:get, 'https://my.brokermint.com/api/v1/transactions/1234/participants/users/1234').
        to_return(status: 200, body: api_fixture('transaction_participants/user_1234'))

      connection = Brokermint::Client.new('access_token').connection
      resource = Brokermint::TransactionParticipantResource.new(connection: connection)

      @transaction_participant = resource.user(transaction_id: 1234, user_id: 1234)
    end

    def test_returns_a_transaction_participant_user
      assert_instance_of Brokermint::TransactionParticipant, @transaction_participant
    end

    def test_maps_a_transaction_participant_user_correctly
      assert_equal 1234, @transaction_participant.id
      assert_equal 'transaction owner', @transaction_participant.role
      assert_equal 'User', @transaction_participant.type
      assert_equal true, @transaction_participant.owner
      assert_equal 'minerva.mcgonagall@hogwarts.edu', @transaction_participant.email
      assert_equal 'Minerva', @transaction_participant.first_name
      assert_equal 'McGonagall', @transaction_participant.last_name
    end

  end

  class CreateContact < Minitest::Test
    def test_creates_and_returns_a_transaction
      brokermint_transaction_participant = Brokermint::TransactionParticipant.new(
        id: 'TEST-ID1',
        role: 'Agent'
      )
      stub_request(:post, 'https://my.brokermint.com/api/v1/transactions/1234/participants/contacts').
        with(body: Brokermint::TransactionParticipantMapping.representation_for(:create, brokermint_transaction_participant)).
        to_return(status: 201, body: api_fixture('transaction_participants/contact_1234'))
      connection = Brokermint::Client.new('access_token').connection
      resource = Brokermint::TransactionParticipantResource.new(connection: connection)

      transaction_participant = resource.create_contact(brokermint_transaction_participant, transaction_id: 1234)

      assert_instance_of Brokermint::TransactionParticipant, transaction_participant
      assert_equal 1234, transaction_participant.id
      assert_equal 'Agent', transaction_participant.role
      assert_equal 'Contact', transaction_participant.type
      assert_equal false, transaction_participant.owner
      assert_equal 'angelina.johnson@hogwarts.edu', transaction_participant.email
      assert_equal 'Angelina', transaction_participant.first_name
      assert_equal 'Johnson', transaction_participant.last_name
    end
  end

  class CreateUser < Minitest::Test
    def test_creates_and_returns_a_transaction
      brokermint_transaction_participant = Brokermint::TransactionParticipant.new(
        id: 'TEST-ID1',
        role: 'Agent'
      )
      stub_request(:post, 'https://my.brokermint.com/api/v1/transactions/1234/participants/users').
        with(body: Brokermint::TransactionParticipantMapping.representation_for(:create, brokermint_transaction_participant)).
        to_return(status: 201, body: api_fixture('transaction_participants/user_1234'))
      connection = Brokermint::Client.new('access_token').connection
      resource = Brokermint::TransactionParticipantResource.new(connection: connection)

      transaction_participant = resource.create_user(brokermint_transaction_participant, transaction_id: 1234)

      assert_instance_of Brokermint::TransactionParticipant, transaction_participant
      assert_equal 1234, transaction_participant.id
      assert_equal 'transaction owner', transaction_participant.role
      assert_equal 'User', transaction_participant.type
      assert_equal true, transaction_participant.owner
      assert_equal 'minerva.mcgonagall@hogwarts.edu', transaction_participant.email
      assert_equal 'Minerva', transaction_participant.first_name
      assert_equal 'McGonagall', transaction_participant.last_name
    end
  end

  class UpdateContact < Minitest::Test
    def test_updates_and_returns_a_transaction
      brokermint_transaction_participant = Brokermint::TransactionParticipant.new(
        role: 'Seller'
      )
      stub_request(:put, 'https://my.brokermint.com/api/v1/transactions/1234/participants/contacts/1234').
        with(body: "{\"role\":\"Seller\"}").
        to_return(status: 201, body: api_fixture('transaction_participants/contact_1234'))
      connection = Brokermint::Client.new('access_token').connection
      resource = Brokermint::TransactionParticipantResource.new(connection: connection)

      transaction_participant = resource.update_contact(brokermint_transaction_participant, transaction_id: 1234, contact_id: 1234)

      assert_instance_of Brokermint::TransactionParticipant, transaction_participant
      assert_equal 1234, transaction_participant.id
      assert_equal 'Agent', transaction_participant.role
      assert_equal 'Contact', transaction_participant.type
      assert_equal false, transaction_participant.owner
      assert_equal 'angelina.johnson@hogwarts.edu', transaction_participant.email
      assert_equal 'Angelina', transaction_participant.first_name
      assert_equal 'Johnson', transaction_participant.last_name
    end
  end

  class UpdateUser < Minitest::Test
    def test_updates_and_returns_a_transaction
      brokermint_transaction_participant = Brokermint::TransactionParticipant.new(
        role: 'Broker'
      )
      stub_request(:put, 'https://my.brokermint.com/api/v1/transactions/1234/participants/users/1234').
        with(body: "{\"role\":\"Broker\"}").
        to_return(status: 201, body: api_fixture('transaction_participants/user_1234'))
      connection = Brokermint::Client.new('access_token').connection
      resource = Brokermint::TransactionParticipantResource.new(connection: connection)

      transaction_participant = resource.update_user(brokermint_transaction_participant, transaction_id: 1234, user_id: 1234)

      assert_instance_of Brokermint::TransactionParticipant, transaction_participant
      assert_equal 1234, transaction_participant.id
      assert_equal 'transaction owner', transaction_participant.role
      assert_equal 'User', transaction_participant.type
      assert_equal true, transaction_participant.owner
      assert_equal 'minerva.mcgonagall@hogwarts.edu', transaction_participant.email
      assert_equal 'Minerva', transaction_participant.first_name
      assert_equal 'McGonagall', transaction_participant.last_name
    end
  end

  class DestroyContact < Minitest::Test
    def test_returns_true_for_a_destroy_response
      stub_request(:delete, 'https://my.brokermint.com/api/v1/transactions/1234/participants/contacts/1234').
        to_return(status: 200, body: '')
      connection = Brokermint::Client.new('access_token').connection
      resource = Brokermint::TransactionParticipantResource.new(connection: connection)

      transaction_participant = resource.destroy_contact(transaction_id: 1234, contact_id: 1234)

      assert_equal true, transaction_participant
    end
  end

  class DestroyUser < Minitest::Test
    def test_returns_true_for_a_destroy_response
      stub_request(:delete, 'https://my.brokermint.com/api/v1/transactions/1234/participants/users/1234').
        to_return(status: 200, body: '')
      connection = Brokermint::Client.new('access_token').connection
      resource = Brokermint::TransactionParticipantResource.new(connection: connection)

      transaction_participant = resource.destroy_user(transaction_id: 1234, user_id: 1234)

      assert_equal true, transaction_participant
    end
  end

end
