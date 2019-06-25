module Brokermint
  class TransactionParticipantResource < ResourceKit::Resource
    include ErrorHandlingResourcable

    resources do

      # GET /transactions/:transaction_id/participants
      action :all do
        verb :get
        path "#{Brokermint.configuration.path_url}/transactions/:transaction_id/participants"
        handler(200) { |response| TransactionParticipantMapping.extract_collection(response.body, :read) }
      end

      # GET /transactions/:transaction_id/participants/contacts
      action :contacts do
        verb :get
        path "#{Brokermint.configuration.path_url}/transactions/:transaction_id/participants/contacts"
        handler(200) { |response| TransactionParticipantMapping.extract_collection(response.body, :read) }
      end

      # GET /transactions/:transaction_id/participants/users
      action :users do
        verb :get
        path "#{Brokermint.configuration.path_url}/transactions/:transaction_id/participants/users"
        handler(200) { |response| TransactionParticipantMapping.extract_collection(response.body, :read) }
      end

      # GET /transactions/:transaction_id/participants/contacts/:contact_id
      action :contact do
        verb :get
        path "#{Brokermint.configuration.path_url}/transactions/:transaction_id/participants/contacts/:contact_id"
        handler(200) { |response| TransactionParticipantMapping.extract_single(response.body, :read) }
      end

      # GET /transactions/:transaction_id/participants/users/:user_id
      action :user do
        verb :get
        path "#{Brokermint.configuration.path_url}/transactions/:transaction_id/participants/users/:user_id"
        handler(200) { |response| TransactionParticipantMapping.extract_single(response.body, :read) }
      end

      # POST /transactions/:transaction_id/participants/contacts
      action :create_contact do
        verb :post
        body { |object| TransactionParticipantMapping.representation_for(:create, object) }
        path "#{Brokermint.configuration.path_url}/transactions/:transaction_id/participants/contacts"
        handler(201) { |response| TransactionParticipantMapping.extract_single(response.body, :read) }
      end

      # POST /transactions/:transaction_id/participants/users
      action :create_user do
        verb :post
        body { |object| TransactionParticipantMapping.representation_for(:create, object) }
        path "#{Brokermint.configuration.path_url}/transactions/:transaction_id/participants/users"
        handler(201) { |response| TransactionParticipantMapping.extract_single(response.body, :read) }
      end

      # PUT /transactions/:transaction_id/participants/contacts/:contact_id
      action :update_contact do
        verb :put
        path "#{Brokermint.configuration.path_url}/transactions/:transaction_id/participants/contacts/:contact_id"
        body { |object| TransactionParticipantMapping.hash_for(:create, object).select{ |_, value| !value.nil? }.to_json }
        handler(201) { |response| TransactionParticipantMapping.extract_single(response.body, :read) }
      end

      # PUT /transactions/:transaction_id/participants/users/:user_id
      action :update_user do
        verb :put
        path "#{Brokermint.configuration.path_url}/transactions/:transaction_id/participants/users/:user_id"
        body { |object| TransactionParticipantMapping.hash_for(:create, object).select{ |_, value| !value.nil? }.to_json }
        handler(201) { |response| TransactionParticipantMapping.extract_single(response.body, :read) }
      end

      # DELETE /transactions/:transaction_id/participants/contacts/:contact_id
      action :destroy_contact do
        verb :delete
        path "#{Brokermint.configuration.path_url}/transactions/:transaction_id/participants/contacts/:contact_id"
        handler(200) { |_| true }
      end

      # DELETE /transactions/:transaction_id/participants/users/:user_id
      action :destroy_user do
        verb :delete
        path "#{Brokermint.configuration.path_url}/transactions/:transaction_id/participants/users/:user_id"
        handler(200) { |_| true }
      end

    end

  end
end
