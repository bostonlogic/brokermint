# List: GET https://my.brokermint.com/api/v1/reports
# Data: GET https://my.brokermint.com/api/v1/reports/<report-id>
# Filters: GET https://my.brokermint.com/api/v1/reports/<report-id>/filters

module Brokermint
  class ReportResource < ResourceKit::Resource
    include ErrorHandlingResourcable

    resources do

      # GET /reports
      action :all do
        verb :get
        path "#{Brokermint.configuration.path_url}/reports"
        handler(200) { |response| ReportMapping.extract_collection(response.body, :all) }
      end

      # GET /reports/:report_id
      action :find do
        verb :get
        path "#{Brokermint.configuration.path_url}/reports/:report_id"
        handler(200) { |response| ReportMapping.extract_single(response.body, :read) }
      end

      # GET /reports/:report_id/filters
      action :filters do
        verb :get
        path "#{Brokermint.configuration.path_url}/reports/:report_id/filters"
        handler(200) { |response| ReportFilterMapping.extract_collection(response.body, :read) }
      end

    end

  end
end
