module Brokermint
  class ReportFilter < BaseModel
    attribute :column
    attribute :type
    attribute :dynamic
    attribute :options, Array(ReportFilterOption)
  end
end
