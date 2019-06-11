module Brokermint
  class CommentMapping
    include Kartograph::DSL

    kartograph do
      mapping Comment

      scoped :read, :create, :update do
        property :created_at
        property :text
        property :author
        property :author_id
      end

    end
  end
end
