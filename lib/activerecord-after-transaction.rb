require 'active_record'
require 'activerecord_after_transaction/version'
require 'activerecord_after_transaction/methods'

ActiveSupport.on_load :active_record do
  include ActiveRecord::AfterTransaction::Methods
end
