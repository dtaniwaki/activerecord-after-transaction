require 'spec_helper'
require 'activerecord-after-transaction/methods'

describe ActiveRecord::AfterTransaction::Methods do
  let(:klass) do
    create_tmp_model foo: :integer do
      include ActiveRecord::AfterTransaction::Methods
    end
  end
  subject { klass.new }

  describe 'in a transaction' do
    it 'executes the proc after transaction' do
      step = 1
      klass.transaction do
        subject.after_transaction do
          step = 2
        end
        subject.save!
        step = 3
      end
      expect(step).to eq 2
    end
    it 'clears executed procs' do
      step = 1
      klass.transaction do
        subject.after_transaction do
          step += 1
        end
        subject.save!
        subject.save!
      end
      expect(step).to eq 2
    end
    it 'does not execute the proc after rollback' do
      step = 1
      klass.transaction do
        subject.after_transaction do
          step = 2
        end
        subject.save!
        raise ActiveRecord::Rollback
      end
      expect(step).to eq 1
    end
  end
  describe 'not in a transaction' do
    it 'executes the proc immediately' do
      step = 1

      subject.after_transaction do
        step = 2
      end
      expect(step).to eq 1
    end
  end
end
