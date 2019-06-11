module ErrorHandlingResourcable
  def self.included(base)
    base.send(:resources) do
      default_handler do |response|
        if (200...299).include?(response.status)
          next
        elsif response.status == 401
          raise Brokermint::UnauthorizedError.new("#{response.status}: #{response.body}")
        elsif response.status == 403
          raise Brokermint::ForbiddenError.new("#{response.status}: #{response.body}")
        elsif response.status == 404
          raise Brokermint::NotFoundError.new("#{response.status}: #{response.body}")
        else
          raise Brokermint::Error.new("#{response.status}: #{response.body}")
        end
      end
    end
  end
end
