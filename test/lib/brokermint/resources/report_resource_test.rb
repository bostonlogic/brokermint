require 'test_helper'

class Brokermint::ReportResourceTest < Minitest::Test

  class All < Minitest::Test

    def setup
      stub_request(:get, 'https://my.brokermint.com/api/v1/reports').
        with(query: {api_key: 'alohomora'}).
        to_return(status: 200, body: api_fixture('reports/all'))

      connection = Brokermint::Client.new('alohomora').connection
      resource = Brokermint::ReportResource.new(connection: connection)

      @reports = resource.all
    end

    def test_returns_an_array_of_available_reports
      assert_instance_of Array, @reports
      assert_equal 18, @reports.size
      @reports.each{ |report| assert_instance_of Brokermint::Report, report }
    end

    def test_correctly_maps_report
      assert_equal 'Agent profile', @reports.first.name
      assert_equal 'agents_profile', @reports.first.id

      assert_equal 'Transaction documents', @reports.last.name
      assert_equal 'transaction_documents', @reports.last.id
    end

  end

  class Find < Minitest::Test

    def test_fetches_and_maps_brokerage_yoy_report
      skip('Unsure of how to elegantly map this endpoint, back-burner')
      stub_request(:get, 'https://my.brokermint.com/api/v1/reports/<report-id>').
        with(query: {api_key: 'alohomora'}).
        to_return(status: 200, body: api_fixture('reports/transaction_documents'))

      connection = Brokermint::Client.new('alohomora').connection
      resource = Brokermint::ReportResource.new(connection: connection)

      report = resource.find(report_id: 'brokerage_yoy')

      assert_instance_of Brokermint::Report, report
    end

    def test_fetches_and_maps_co_op_brokers_report
      skip('Unsure of how to elegantly map this endpoint, back-burner')
      stub_request(:get, 'https://my.brokermint.com/api/v1/reports/<report-id>').
        with(query: {api_key: 'alohomora'}).
        to_return(status: 200, body: api_fixture('reports/transaction_documents'))

      connection = Brokermint::Client.new('alohomora').connection
      resource = Brokermint::ReportResource.new(connection: connection)

      report = resource.find(report_id: 'brokerage_yoy')

      assert_instance_of Brokermint::Report, report
    end

    def test_fetches_and_maps_production_report
      skip('Unsure of how to elegantly map this endpoint, back-burner')
      stub_request(:get, 'https://my.brokermint.com/api/v1/reports/<report-id>').
        with(query: {api_key: 'alohomora'}).
        to_return(status: 200, body: api_fixture('reports/transaction_documents'))

      connection = Brokermint::Client.new('alohomora').connection
      resource = Brokermint::ReportResource.new(connection: connection)

      report = resource.find(report_id: 'brokerage_yoy')

      assert_instance_of Brokermint::Report, report
    end

    def test_fetches_and_maps_transasction_documents_report
      skip('Unsure of how to elegantly map this endpoint, back-burner')
      stub_request(:get, 'https://my.brokermint.com/api/v1/reports/<report-id>').
        with(query: {api_key: 'alohomora'}).
        to_return(status: 200, body: api_fixture('reports/transaction_documents'))

      connection = Brokermint::Client.new('alohomora').connection
      resource = Brokermint::ReportResource.new(connection: connection)

      report = resource.find(report_id: 'brokerage_yoy')

      assert_instance_of Brokermint::Report, report
    end

  end

  class Filters < Minitest::Test

    def setup
      stub_request(:get, 'https://my.brokermint.com/api/v1/reports/transaction_documents/filters').
        with(query: {api_key: 'alohomora'}).
        to_return(status: 200, body: api_fixture('reports/filters'))

      connection = Brokermint::Client.new('alohomora').connection
      resource = Brokermint::ReportResource.new(connection: connection)

      @report_filters = resource.filters(report_id: 'transaction_documents')
    end

    def test_returns_an_array_of_report_filters
      assert_instance_of Array, @report_filters
      assert_equal 2, @report_filters.size
      @report_filters.each{ |report_filter| assert_instance_of Brokermint::ReportFilter, report_filter }
    end

    def test_maps_the_filters_correctly
      assert_equal 'status', @report_filters.first.column
      assert_equal true, @report_filters.first.dynamic
      assert_nil @report_filters.first.type
      @report_filters.first.options.each{ |report_filter_option| assert_instance_of Brokermint::ReportFilterOption, report_filter_option }

      assert_equal 'document_status', @report_filters.last.column
      assert_equal true, @report_filters.last.dynamic
      assert_nil @report_filters.last.type
      @report_filters.last.options.each{ |report_filter_option| assert_instance_of Brokermint::ReportFilterOption, report_filter_option }
    end

    def test_maps_the_filter_options_correctly
      assert_equal 'listing_pending', @report_filters.first.options.first.val
      assert_equal 'listing + pending', @report_filters.first.options.first.text

      assert_equal '*', @report_filters.first.options.last.val
      assert_equal 'all statuses', @report_filters.first.options.last.text
    end

  end

end
