module Brokermint
  class RepresenterMapping
    include Kartograph::DSL

    kartograph do
      mapping Representer

      scoped :read, :create, :update do
        property :id
        property :type
      end

    end
  end
end
