require 'test_helper'

class Brokermint::TransactionCommissionResourceTest < Minitest::Test

  class All < Minitest::Test

    def setup
      stub_request(:get, 'https://my.brokermint.com/api/v1/transactions/1234/commissions').
        to_return(status: 200, body: api_fixture('transaction_commissions/all'))
      connection = Brokermint::Client.new('access_token').connection
      resource = Brokermint::TransactionCommissionResource.new(connection: connection)

      @transaction_commissions = resource.all(transaction_id: 1234)
    end

    def test_returns_an_array_of_transaction_commissions
      assert_instance_of Array, @transaction_commissions
      @transaction_commissions.each{ |transaction_commission| assert_instance_of Brokermint::TransactionCommission, transaction_commission }
    end

    def test_transaction_commission_is_mapped_properly
      transaction_commission = @transaction_commissions.first

      assert_equal 1234, transaction_commission.id
      assert_equal '', transaction_commission.name
      assert_equal 'tgc', transaction_commission.item_type
      assert_nil transaction_commission.side
      assert_equal 1234, transaction_commission.payer_id
      assert_equal 'Account', transaction_commission.payer_type
      assert_equal 1234, transaction_commission.payee_id
      assert_equal 'Account', transaction_commission.payee_type
      assert_nil transaction_commission.sliding_base
      assert_nil transaction_commission.sliding_base_period
      assert_equal 10250, transaction_commission.calculated_dollar_amount
      assert_equal 0, transaction_commission.minimum_dollar_amount
      assert_instance_of Brokermint::TransactionCommissionPayee, transaction_commission.pay_to
      assert_equal [], transaction_commission.custom_sliding_base_period
      assert_nil transaction_commission.sliding_base_amount
      assert_nil transaction_commission.applied_plan
      assert_nil transaction_commission.maximum_dollar_amount
      assert_nil transaction_commission.prorated_according_to
      assert_nil transaction_commission.sliding_base_accrued_by
      assert_instance_of Array, transaction_commission.tiers
      assert_equal [], transaction_commission.tags
      assert_equal 'Order of the Phoenix', transaction_commission.payee_name
      assert_nil transaction_commission.payee_first_name
      assert_nil transaction_commission.payee_last_name
      assert_equal 'Order of the Phoenix', transaction_commission.payee_company
      assert_equal 'Order of the Phoenix', transaction_commission.payer_name
    end

    def test_pay_to_is_mapped_properly
      commission_payee = @transaction_commissions.last.pay_to

      assert_equal 'Neville', commission_payee.name
      assert_equal 'Longbottom', commission_payee.address
      assert_equal 'Hogsmeade', commission_payee.city
      assert_equal 'Scotland', commission_payee.state
      assert_equal 'MUGGLE-FREE', commission_payee.zip
    end

    def test_tiers_are_mapped_properly
      commission_tiers = @transaction_commissions.first.tiers

      assert_instance_of Array, commission_tiers
      assert_instance_of Brokermint::TransactionCommissionTier, commission_tiers.first

      assert_equal 5926892, commission_tiers.first.id
      assert_equal 37849165, commission_tiers.first.commission_item_id
      assert_equal 0, commission_tiers.first.low_limit
      assert_equal 5, commission_tiers.first.value
      assert_equal '% of price sold', commission_tiers.first.uom
    end

    def test_tags_are_mapped_properly
      commission_tags = @transaction_commissions.last.tags
      
      assert_equal ['1099', 'extra comm'], commission_tags
    end

  end

  end
