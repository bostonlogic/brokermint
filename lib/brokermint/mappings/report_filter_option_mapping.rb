module Brokermint
  class ReportFilterOptionMapping
    include Kartograph::DSL

    kartograph do
      mapping ReportFilterOption

      scoped :read do
        property :val
        property :text
      end

    end
  end
end
