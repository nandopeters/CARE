source 'https://rubygems.org'
ruby '2.0.0'
gem 'rails', '4.0.1'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
# gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'cancan'
gem 'devise'
gem 'figaro'
gem 'pg'
gem 'puma'
gem 'rolify'

gem "font-awesome-rails"

gem "stripe"
gem "stripe_event"

gem "redis"
gem 'resque', :require => 'resque/server'
gem 'resque-pool'
gem 'resque-scheduler', :require => ['resque_scheduler', 'resque_scheduler/server']

gem "pusher"

gem "twilio-ruby"


group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :mri_20, :rbx]
  gem 'quiet_assets'
  gem 'rails_layout'
end
group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
end
group :test do
  gem 'capybara'
  gem 'database_cleaner', '1.0.1'
  gem 'email_spec'
end
