module Brokermint
  class TransactionResource < ResourceKit::Resource
    include ErrorHandlingResourcable

    resources do

      # GET /transactions
      action :all do
        verb :get
        query_keys :created_since, :updated_since, :closed_since, :statuses, :owned_by, :external_ids, :full_info
        path "#{Brokermint.configuration.path_url}/transactions"
        handler(200) { |response| TransactionMapping.extract_collection(response.body, :read) }
      end

      # GET /transactions/:transaction_id
      action :find do
        verb :get
        path "#{Brokermint.configuration.path_url}/transactions/:transaction_id"
        handler(200) { |response| TransactionMapping.extract_single(response.body, :read) }
      end

      # POST /transactions
      action :create do
        verb :post
        body { |object| TransactionMapping.representation_for(:create, object) }
        path "#{Brokermint.configuration.path_url}/transactions"
        handler(201) { |response| TransactionMapping.extract_single(response.body, :read) }
      end

      # PUT /transactions/:transaction_id
      action :update do
        verb :put
        body { |object| TransactionMapping.hash_for(:create, object).select{ |_, value| !value.nil? }.to_json }
        path "#{Brokermint.configuration.path_url}/transactions/:transaction_id"
        handler(200) { |response| TransactionMapping.extract_single(response.body, :read) }
      end

      # DELETE /transactions/:transaction_id
      action :destroy do
        verb :delete
        path "#{Brokermint.configuration.path_url}/transactions/:transaction_id"
        handler(200) { |_| true }
      end

    end

  end
end
