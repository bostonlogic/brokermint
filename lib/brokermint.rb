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
  autoload :TransactionBackupMapping, 'brokermint/mappings/transaction_backup_mapping'
  autoload :TransactionChecklistMapping, 'brokermint/mappings/transaction_checklist_mapping'
  autoload :TransactionCommissionMapping, 'brokermint/mappings/transaction_commission_mapping'
  autoload :TransactionCommissionPayeeMapping, 'brokermint/mappings/transaction_commission_payee_mapping'
  autoload :TransactionCommissionTierMapping, 'brokermint/mappings/transaction_commission_tier_mapping'
  autoload :TransactionMapping, 'brokermint/mappings/transaction_mapping'
  autoload :TransactionParticipantMapping, 'brokermint/mappings/transaction_participant_mapping'
  autoload :TransactionTaskMapping, 'brokermint/mappings/transaction_task_mapping'
  autoload :UserMapping, 'brokermint/mappings/user_mapping'

  autoload :BaseModel, 'brokermint/models/base_model'
  autoload :Comment, 'brokermint/models/comment'
  autoload :Contact, 'brokermint/models/contact'
  autoload :CustomAttribute, 'brokermint/models/custom_attribute'
  autoload :Representer, 'brokermint/models/representer'
  autoload :Transaction, 'brokermint/models/transaction'
  autoload :TransactionBackup, 'brokermint/models/transaction_backup'
  autoload :TransactionChecklist, 'brokermint/models/transaction_checklist'
  autoload :TransactionCommission, 'brokermint/models/transaction_commission'
  autoload :TransactionCommissionPayee, 'brokermint/models/transaction_commission_payee'
  autoload :TransactionCommissionTier, 'brokermint/models/transaction_commission_tier'
  autoload :TransactionParticipant, 'brokermint/models/transaction_participant'
  autoload :TransactionTask, 'brokermint/models/transaction_task'
  autoload :User, 'brokermint/models/user'

  autoload :ContactResource, 'brokermint/resources/contact_resource'
  autoload :TransactionBackupResource, 'brokermint/resources/transaction_backup_resource'
  autoload :TransactionChecklistResource, 'brokermint/resources/transaction_checklist_resource'
  autoload :TransactionCommissionResource, 'brokermint/resources/transaction_commission_resource'
  autoload :TransactionParticipantResource, 'brokermint/resources/transaction_participant_resource'
  autoload :TransactionResource, 'brokermint/resources/transaction_resource'
  autoload :TransactionTaskResource, 'brokermint/resources/transaction_task_resource'
  autoload :UserResource, 'brokermint/resources/user_resource'

  autoload :ErrorHandlingResourcable, 'brokermint/error_handling_resourcable'
  # autoload :PaginatedResource, 'brokermint/paginated_resource'

  autoload :ErrorMapping, 'brokermint/mappings/error_mapping'
  Error = Class.new(StandardError)
  UnauthorizedError = Class.new(Brokermint::Error)
  ForbiddenError = Class.new(Brokermint::Error)
  NotFoundError = Class.new(Brokermint::Error)
end
