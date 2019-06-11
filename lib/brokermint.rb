require 'brokermint/version'
require 'brokermint/configuration'
require 'resource_kit'
require 'kartograph'

module Brokermint
  autoload :Client, 'brokermint/client'

  autoload :CommentMapping, 'brokermint/mappings/comment_mapping'
  autoload :ContactMapping, 'brokermint/mappings/contact_mapping'
  autoload :CustomAttributeMapping, 'brokermint/mappings/custom_attribute_mapping'
  autoload :RepresenterMapping, 'brokermint/mappings/representer_mapping'
  autoload :TransactionMapping, 'brokermint/mappings/transaction_mapping'
  autoload :UserMapping, 'brokermint/mappings/user_mapping'

  autoload :BaseModel, 'brokermint/models/base_model'
  autoload :Comment, 'brokermint/models/comment'
  autoload :Contact, 'brokermint/models/contact'
  autoload :CustomAttribute, 'brokermint/models/custom_attribute'
  autoload :Representer, 'brokermint/models/representer'
  autoload :Transaction, 'brokermint/models/transaction'
  autoload :User, 'brokermint/models/user'

  autoload :ContactResource, 'brokermint/resources/contact_resource'
  autoload :TransactionResource, 'brokermint/resources/transaction_resource'
  autoload :UserResource, 'brokermint/resources/user_resource'

  autoload :ErrorHandlingResourcable, 'brokermint/error_handling_resourcable'
  # autoload :PaginatedResource, 'brokermint/paginated_resource'

  autoload :ErrorMapping, 'brokermint/mappings/error_mapping'
  Error = Class.new(StandardError)
  UnauthorizedError = Class.new(Brokermint::Error)
  ForbiddenError = Class.new(Brokermint::Error)
  NotFoundError = Class.new(Brokermint::Error)
end
