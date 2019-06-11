module Brokermint
  class Comment < BaseModel
    attribute :created_at
    attribute :text
    attribute :author
    attribute :author_id
  end
end
