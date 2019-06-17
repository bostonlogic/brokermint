module Brokermint
  class ReportFilterMapping
    include Kartograph::DSL

    kartograph do
      mapping ReportFilter

      scoped :read do
        property :column
        property :dynamic
        property :type
        property :options, plural: true, include: ReportFilterOptionMapping
      end

    end
  end
end
