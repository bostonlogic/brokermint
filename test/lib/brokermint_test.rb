require 'test_helper'

class BrokermintTest < Minitest::Test

  def test_that_it_has_a_version_number
    refute_nil ::Brokermint::VERSION
  end

  def test_error_is_initialized
    assert Brokermint::Error
  end

  def test_unauthorized_error_is_initialized
    assert Brokermint::UnauthorizedError
  end

  def test_forbidden_error_is_initialized
    assert Brokermint::ForbiddenError
  end

  def test_not_found_error_is_initialized
    assert Brokermint::NotFoundError
  end

end
