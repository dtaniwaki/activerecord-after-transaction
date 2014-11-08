# activerecord-after-transaction

[![Gem Version][gem-image]][gem-link]
[![Dependency Status][deps-image]][deps-link]
[![Build Status][build-image]][build-link]
[![Coverage Status][cov-image]][cov-link]
[![Code Climate][gpa-image]][gpa-link]

Execute a proc after transaction.

You basically don't need this gem if you use `after_commit`. However, let's say you have `state_machine` gem and want to do something after transition, the gem doesn't provide a way to do it. In this case, you might have written the following code.

```ruby
def after_commit(record)
  if record.previous_changes[:state] == ['draft', 'published']
    UserMailer.notify_publish(record).deliver
  elsif record.previous_changes[:state] == ['draft', 'deleted']
    UserMailer.notify_delete(record).deliver
  end 
end 
```

It spoils the readability of `state_machine`. You definitely want to write the following instead.

```ruby
after_transition from: :draft, to: :published do
  UserMailer.notify_publish(record).deliver
end
after_transition from: :draft, to: :deleted do
  UserMailer.notify_publish(record).deliver
end
```

That's why I made this gem. :)

## Installation

Add the activerecord-after-transaction gem to your Gemfile.

```ruby
gem "activerecord-after-transaction"
```

And run `bundle install`.

## Usage

Just enslose what you want to execute with `after_transaction`.

```ruby
class Foo < ActiveRecord::Base
  def after_transition(record, transition)
    if transition.to == :published
      after_transaction do
        UserMailer.notify_publish(record).deliver
      end
    elsif transition.to == :deleted
      after_transaction do
        UserMailer.notify_delete(record).deliver
      end
    end
  end
end
```

Then, the proc will be executed after the transaction. If it's not in the transaction, it will be executed immediately.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new [Pull Request](../../pull/new/master)

## Copyright

Copyright (c) 2014 Daisuke Taniwaki. See [LICENSE](LICENSE) for details.



[gem-image]:   https://badge.fury.io/rb/activerecord-after-transaction.svg
[gem-link]:    http://badge.fury.io/rb/activerecord-after-transaction
[build-image]: https://secure.travis-ci.org/dtaniwaki/activerecord-after-transaction.png
[build-link]:  http://travis-ci.org/dtaniwaki/activerecord-after-transaction
[deps-image]:  https://gemnasium.com/dtaniwaki/activerecord-after-transaction.svg
[deps-link]:   https://gemnasium.com/dtaniwaki/activerecord-after-transaction
[cov-image]:   https://codeclimate.com/github/dtaniwaki/activerecord-after-transaction/badges/coverage.svg
[cov-link]:    https://codeclimate.com/github/dtaniwaki/activerecord-after-transaction
[gpa-image]:   https://codeclimate.com/github/dtaniwaki/activerecord-after-transaction.png
[gpa-link]:    https://codeclimate.com/github/dtaniwaki/activerecord-after-transaction

