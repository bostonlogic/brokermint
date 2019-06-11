require 'test_helper'

class Brokermint::ClientTest < Minitest::Test

  class Initialize < Minitest::Test

    def test_initialize_requires_an_access_token
      assert_raises(ArgumentError) { Brokermint::Client.new }
    end

    def test_initialize_creates_a_brokermint_client_instance
      brokermint_client = Brokermint::Client.new('alohomora')

      assert_instance_of Brokermint::Client, brokermint_client
    end

    def test_initialize_sets_the_provided_access_token
      brokermint_client = Brokermint::Client.new('alohomora')

      assert_equal 'alohomora', brokermint_client.api_key
    end

  end

  class Connection < Minitest::Test

    def test_connection_sets_the_correct_url
      brokermint_client = Brokermint::Client.new('alohomora')

      assert_equal 'https://my.brokermint.com/', brokermint_client.connection.url_prefix.to_s
    end

    def test_connection_builds_the_correct_headers
      brokermint_client = Brokermint::Client.new('alohomora')

      assert_equal 'application/json', brokermint_client.connection.headers[:content_type]
    end

  end

  class MethodMissing < Minitest::Test

    def test_valid_endpoints_succeed
      brokermint_client = Brokermint::Client.new('alohomora')

      assert brokermint_client.contacts
    end

    def test_invalid_endpoints_raise_method_missing_error
      brokermint_client = Brokermint::Client.new('alohomora')

      assert_raises(NoMethodError) { brokermint_client.not_a_thing }
    end

  end

end
