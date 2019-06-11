module Brokermint

  class Configuration
    attr_accessor :api_url
    attr_accessor :path_url

    def initialize
      @api_url  = 'https://my.brokermint.com'
      @path_url = 'api/v1'
    end
  end

  class << self

    def configuration
      @configuration ||= Configuration.new
    end

    def self.configuration=(config)
      @configuration = config
    end

    def configure
      yield(configuration)
    end

  end
end
