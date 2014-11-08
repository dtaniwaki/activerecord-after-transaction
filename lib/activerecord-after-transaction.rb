require 'active_record'
require 'activerecord-after-transaction/version'
require 'activerecord-after-transaction/methods'

ActiveSupport.on_load :active_record do
  include ActiveRecord::AfterTransaction::Methods
end
