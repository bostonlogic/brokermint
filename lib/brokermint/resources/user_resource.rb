module Brokermint
  class UserResource < ResourceKit::Resource
    include ErrorHandlingResourcable

    resources do

      # GET /users
      action :all do
        verb :get
        query_keys :created_since, :updated_since, :external_ids, :full_info
        path "#{Brokermint.configuration.path_url}/users"
        handler(200) { |response| UserMapping.extract_collection(response.body, :all) }
      end

      # GET /users/:user_id
      action :find do
        verb :get
        path "#{Brokermint.configuration.path_url}/users/:user_id"
        handler(200) { |response| UserMapping.extract_single(response.body, :read) }
      end

      # GET /users/:user_id/sso_token
      action :sso_token do
        verb :get
        path "#{Brokermint.configuration.path_url}/users/:user_id/sso_token"
        handler(200) { |response| UserMapping.extract_single(response.body, :sso_token) }
      end

    end

  end
end
