require 'test_helper'

class Brokermint::UserResourceTest < Minitest::Test

  class All < Minitest::Test

    def test_returns_an_array_of_users
      stub_request(:get, "https://my.brokermint.com/api/v1/users").
        with(query: {api_key: 'alohomora'}).
        to_return(status: 200, body: api_fixture('users/all'))
      connection = Brokermint::Client.new('alohomora').connection
      resource = Brokermint::UserResource.new(connection: connection)

      users = resource.all

      assert_instance_of Array, users
      users.each{ |user| assert_instance_of Brokermint::User, user }
    end

    def test_uses_passed_in_query_keys
      stub_request(:get, "https://my.brokermint.com/api/v1/users").
        with(query: {api_key: 'alohomora', external_ids: '1,2,3,4'}).
        to_return(status: 200, body: api_fixture('users/all'))
      connection = Brokermint::Client.new('alohomora').connection
      resource = Brokermint::UserResource.new(connection: connection)

      users = resource.all(external_ids: '1,2,3,4')

      assert_instance_of Array, users
      users.each{ |user| assert_instance_of Brokermint::User, user }
    end

  end

  class Find < Minitest::Test
    def test_returns_a_user
      stub_request(:get, "https://my.brokermint.com/api/v1/users/1234").
        with(query: {api_key: 'alohomora'}).
        to_return(status: 200, body: api_fixture('users/1234'))
      connection = Brokermint::Client.new('alohomora').connection
      resource = Brokermint::UserResource.new(connection: connection)

      user = resource.find(user_id: 1234)

      assert_instance_of Brokermint::User, user
      assert_equal 1234, user.id
      assert_equal 'lily.evans@hogwarts.net', user.email
      assert_equal 1558463726484, user.created_at
      assert_equal 1559674689622, user.updated_at
      assert_equal 'Lily', user.first_name
      assert_equal 'Evans', user.last_name
      assert_equal '', user.phone
      assert_equal true, user.active
      assert_nil user.birthday
      assert_equal '', user.company
      assert_nil user.external_id
      assert_equal 'owner', user.role
      assert_equal 1558463728000, user.anniversary_date
      assert_nil user.team
      assert_nil user.address
      assert_nil user.city
      assert_nil user.state
      assert_nil user.zip
      assert_nil user.license_number
      assert_nil user.license_expiration
      assert_equal '/assets/no-logo.png', user.avatar_url
    end
  end

  class SsoToken < Minitest::Test
    def test_returns_a_user_sso_token
      stub_request(:get, "https://my.brokermint.com/api/v1/users/1234/sso_token").
        with(query: {api_key: 'alohomora'}).
        to_return(status: 200, body: api_fixture('users/sso_token'))
      connection = Brokermint::Client.new('alohomora').connection
      resource = Brokermint::UserResource.new(connection: connection)

      user = resource.sso_token(user_id: 1234)

      assert_instance_of Brokermint::User, user
      assert_equal 'IamAnSSO+TokenAndIShouldBeUsedTo=LogInToBrokermint', user.sso_token
    end
  end

end
