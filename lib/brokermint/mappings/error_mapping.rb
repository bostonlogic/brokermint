module Brokermint
  class ErrorMapping

    Error = Struct.new(:error, :status)

    include Kartograph::DSL

    kartograph do
      mapping Error

      scoped :read do
        property :error
        property :status
      end

    end

    def self.fail_with(klass, content)
      error = extract_single(content, :read)
      raise klass, "Code: #{error.code}, Source: #{error.source}"
    end

  end
end
