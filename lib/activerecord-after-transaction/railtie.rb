require 'active_record/railtie'
require 'activerecord-after-transaction/methods'

module ActiveRecordAfterTransaction
  class Railtie < Rails::Railtie
    initializer "active_record.include_after_transaction", after: "active_record.set_configs" do |app|
      ActiveSupport.on_load :active_record do
        include ActiveRecord::AfterTransaction::Methods
      end
    end
  end
end
