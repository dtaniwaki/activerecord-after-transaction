require 'active_record'

module ActiveRecord::AfterTransaction
  module Methods
    def self.included(klass)
      klass.class_eval do
        after_commit :execute_after_transaction
        after_rollback :clear_after_transaction
      end
    end

    def after_transaction(&block)
      return block.call unless self.class.connection.open_transactions
      @after_transaction_queue ||= []
      @after_transaction_queue.push block
      logger && logger.debug("Push #{block}")
    end

    def execute_after_transaction
      queue = @after_transaction_queue
      if !queue.empty?
        logger && logger.debug("Execute the queue")
        queue = queue.dup
        clear_after_transaction
        queue.each do |block|
          logger && logger.debug("Execute #{block}")
          block.call
        end
      end
    end

    def clear_after_transaction
      logger && logger.debug("Clear the queue")
      @after_transaction_queue.clear
    end
  end
end
