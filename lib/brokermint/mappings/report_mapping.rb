module Brokermint
  class ReportMapping
    include Kartograph::DSL

    kartograph do
      mapping Report

      scoped :all do
        property :name
        property :id
      end

    end
  end
end
