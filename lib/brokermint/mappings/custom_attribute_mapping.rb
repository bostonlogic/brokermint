module Brokermint
  class CustomAttributeMapping
    include Kartograph::DSL

    kartograph do
      mapping CustomAttribute

      scoped :read, :create, :update do
        property :type
        property :label
        property :name
        property :value
      end

    end
  end
end
