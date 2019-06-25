module Brokermint
  class TransactionNoteResource < ResourceKit::Resource
    include ErrorHandlingResourcable

    resources do
      # POST /transactions/:transaction_id/notes
      action :create do
        verb :post
        body { |object| TransactionNoteMapping.representation_for(:create, object) }
        path "#{Brokermint.configuration.path_url}/transactions/:transaction_id/notes"
        handler(200) { |_| true }
      end
    end

  end
end
