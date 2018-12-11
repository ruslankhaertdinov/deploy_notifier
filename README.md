# DeployNotifier

Sends chat notifications after (success or failure) deploy

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'deploy_notifier'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install deploy_notifier

## Usage

Set config in config/initializes/deploy_notifier.rb

```
# example:
DeployNotifier.configure do |config|
  config.webhook = 'http://some.webhook.url'
  config.project = 'project_name'
  config.env = Rails.env
end
```

Then call
```
DeployNotifier.new(success: true).send_report
```
or
```
DeployNotifier.new(success: false).send_report
```
to send message.

## Testing

  $ bundle exec rspec spec

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
