require 'active_record'
require 'activerecord-after-transaction/version'
require 'activerecord-after-transaction/methods'

if defined?(::Rails) 
  require 'activerecord-after-transaction/railtie'
else
  ActiveSupport.on_load :active_record do
    include ActiveRecord::AfterTransaction::Methods
  end
end
