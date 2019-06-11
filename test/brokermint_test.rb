require 'test_helper'

class BrokermintTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Brokermint::VERSION
  end
end
