module Brokermint
  class ContactResource < ResourceKit::Resource
    include ErrorHandlingResourcable

    resources do

      # GET /contacts[?created_since=<created_since>&updated_since=<updated_since>&external_ids=<external_ids>]
      action :all do
        verb :get
        query_keys :created_since, :updated_since, :external_ids, :full_info
        path "#{Brokermint.configuration.path_url}/contacts"
        handler(200) { |response| ContactMapping.extract_collection(response.body, :all) }
      end

      # GET /contact/:contact_id
      action :find do
        verb :get
        path "#{Brokermint.configuration.path_url}/contacts/:contact_id"
        handler(200) { |response| ContactMapping.extract_single(response.body, :read) }
      end

      # POST /contact
      action :create do
        verb :post
        body { |object| ContactMapping.representation_for(:create, object) }
        path "#{Brokermint.configuration.path_url}/contacts"
        handler(201) { |response| ContactMapping.extract_single(response.body, :read) }
      end

      # PUT /contact/:contact_id
      action :update do
        verb :put
        body { |object| ContactMapping.hash_for(:update, object).select{ |_, value| !value.nil? }.to_json }
        path "#{Brokermint.configuration.path_url}/contacts/:contact_id"
        handler(200) { |response| ContactMapping.extract_single(response.body, :read) }
      end

      # DELETE /contact/:contact_id
      action :destroy do
        verb :delete
        path "#{Brokermint.configuration.path_url}/contacts/:contact_id"
        handler(200) { |_| true }
      end

    end

  end
end
