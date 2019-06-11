require 'test_helper'

class Brokermint::ContactResourceTest < Minitest::Test

  class All < Minitest::Test
    def test_returns_an_array_of_contacts
      stub_request(:get, "https://my.brokermint.com/api/v1/contacts").
        to_return(status: 200, body: api_fixture('contacts/all'))
      connection = Brokermint::Client.new('access_token').connection
      resource = Brokermint::ContactResource.new(connection: connection)

      contacts = resource.all

      assert_instance_of Array, contacts
      contacts.each{ |contact| assert_instance_of Brokermint::Contact, contact }
    end
  end

  class Find < Minitest::Test

    def test_returns_a_contact
      stub_request(:get, "https://my.brokermint.com/api/v1/contacts/1234").
        to_return(status: 200, body: api_fixture('contacts/1234'))
      connection = Brokermint::Client.new('access_token').connection
      resource = Brokermint::ContactResource.new(connection: connection)

      contact = resource.find(contact_id: 1234)

      assert_instance_of Brokermint::Contact, contact
      assert_equal 1234, contact.id
      assert_equal 'other', contact.contact_type
      assert_equal 'Hermione', contact.first_name
      assert_equal 'Granger', contact.last_name
      assert_equal '', contact.company
      assert_equal '', contact.address
      assert_equal '', contact.city
      assert_equal '', contact.state
      assert_equal '', contact.zip
      assert_equal 'hermione.granger@hogwarts.edu', contact.email
      assert_equal '', contact.phone
      assert_equal '617.123.4567', contact.mobile_phone
      assert_equal '', contact.fax
      assert_equal [], contact.comments
      assert_equal 1559608550896, contact.created_at
      assert_equal 1559608550896, contact.updated_at
      assert_equal '', contact.lead_source
      assert_equal 1871, contact.created_by
      assert_equal false, contact.private
      assert_nil contact.external_id
      assert_equal [], contact.custom_attributes
    end

    def test_returns_a_contact_with_comments
      stub_request(:get, "https://my.brokermint.com/api/v1/contacts/5678").
        to_return(status: 200, body: api_fixture('contacts/5678'))
      connection = Brokermint::Client.new('access_token').connection
      resource = Brokermint::ContactResource.new(connection: connection)

      contact = resource.find(contact_id: 5678)

      assert_instance_of Brokermint::Contact, contact
      assert_equal 5678, contact.id
      assert_equal 'agent', contact.contact_type
      assert_equal 'Luna', contact.first_name
      assert_equal 'Lovegood', contact.last_name
      assert_equal 'Dumbledore\'s Army', contact.company
      assert_equal '', contact.address
      assert_equal '', contact.city
      assert_equal '', contact.state
      assert_equal '', contact.zip
      assert_equal 'luna.lovegood@hogwarts.edu', contact.email
      assert_equal '617.345.6789', contact.phone
      assert_equal '', contact.mobile_phone
      assert_equal '', contact.fax
      contact.comments.each{ |comment| assert_instance_of Brokermint::Comment, comment }
      assert_equal 1559691336034, contact.created_at
      assert_equal 1559702444423, contact.updated_at
      assert_equal '', contact.lead_source
      assert_equal 1871, contact.created_by
      assert_equal false, contact.private
      assert_nil contact.external_id
      assert_equal [], contact.custom_attributes
    end

    def test_returns_a_contact_with_comments_and_maps_them_correctly
      stub_request(:get, "https://my.brokermint.com/api/v1/contacts/5678").
        to_return(status: 200, body: api_fixture('contacts/5678'))
      connection = Brokermint::Client.new('access_token').connection
      resource = Brokermint::ContactResource.new(connection: connection)

      contact = resource.find(contact_id: 5678)

      assert_equal 3, contact.comments.size
      assert_equal 1559702233678, contact.comments.last.created_at
      assert_equal 'There were bananas', contact.comments.last.text
      assert_equal 'Lily Evans', contact.comments.last.author
      assert_equal 1234, contact.comments.last.author_id
    end

  end

  class Create < Minitest::Test
    def test_creates_and_returns_a_contact
      brokermint_contact = Brokermint::Contact.new(
        first_name: 'Hermione',
        last_name: 'Granger',
        email: 'hermione.granger@hogwarts.edu',
        mobile_phone: '617.123.4567'
      )
      stub_request(:post, "https://my.brokermint.com/api/v1/contacts").
        with(body: Brokermint::ContactMapping.representation_for(:create, brokermint_contact)).
        to_return(status: 201, body: api_fixture('contacts/1234'))
      connection = Brokermint::Client.new('access_token').connection
      resource = Brokermint::ContactResource.new(connection: connection)

      contact = resource.create(brokermint_contact)

      assert_instance_of Brokermint::Contact, contact
      assert_equal 1234, contact.id
      assert_equal 'other', contact.contact_type
      assert_equal 'Hermione', contact.first_name
      assert_equal 'Granger', contact.last_name
      assert_equal '', contact.company
      assert_equal '', contact.address
      assert_equal '', contact.city
      assert_equal '', contact.state
      assert_equal '', contact.zip
      assert_equal 'hermione.granger@hogwarts.edu', contact.email
      assert_equal '', contact.phone
      assert_equal '617.123.4567', contact.mobile_phone
      assert_equal '', contact.fax
      assert_equal [], contact.comments
      assert_equal 1559608550896, contact.created_at
      assert_equal 1559608550896, contact.updated_at
      assert_equal '', contact.lead_source
      assert_equal 1871, contact.created_by
      assert_equal false, contact.private
      assert_nil contact.external_id
      assert_equal [], contact.custom_attributes
    end
  end

  class Update < Minitest::Test
    def test_updates_and_returns_a_contact
      brokermint_contact = Brokermint::Contact.new(
        first_name: 'Hermione',
        last_name: 'Granger',
        email: 'hermione.granger@hogwarts.edu',
        mobile_phone: '617.123.4567'
      )
      stub_request(:put, "https://my.brokermint.com/api/v1/contacts/1234").
        with(body: "{\"first_name\":\"Hermione\",\"last_name\":\"Granger\",\"email\":\"hermione.granger@hogwarts.edu\",\"mobile_phone\":\"617.123.4567\",\"custom_attributes\":[]}").
        to_return(status: 200, body: api_fixture('contacts/1234'))
      connection = Brokermint::Client.new('access_token').connection
      resource = Brokermint::ContactResource.new(connection: connection)

      contact = resource.update(brokermint_contact, contact_id: 1234)

      assert_instance_of Brokermint::Contact, contact
      assert_equal 1234, contact.id
      assert_equal 'other', contact.contact_type
      assert_equal 'Hermione', contact.first_name
      assert_equal 'Granger', contact.last_name
      assert_equal '', contact.company
      assert_equal '', contact.address
      assert_equal '', contact.city
      assert_equal '', contact.state
      assert_equal '', contact.zip
      assert_equal 'hermione.granger@hogwarts.edu', contact.email
      assert_equal '', contact.phone
      assert_equal '617.123.4567', contact.mobile_phone
      assert_equal '', contact.fax
      assert_equal [], contact.comments
      assert_equal 1559608550896, contact.created_at
      assert_equal 1559608550896, contact.updated_at
      assert_equal '', contact.lead_source
      assert_equal 1871, contact.created_by
      assert_equal false, contact.private
      assert_nil contact.external_id
      assert_equal [], contact.custom_attributes
    end
  end

  class Destroy < Minitest::Test
    def test_returns_true_for_a_destroy_response
      stub_request(:delete, "https://my.brokermint.com/api/v1/contacts/5678").
        to_return(status: 200, body: '')
      connection = Brokermint::Client.new('access_token').connection
      resource = Brokermint::ContactResource.new(connection: connection)

      contact = resource.destroy(contact_id: 5678)

      assert_equal true, contact
    end
  end

end
