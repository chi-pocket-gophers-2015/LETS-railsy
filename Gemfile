source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '4.2.1'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'

gem 'pg'

gem 'giphy'
# gem 'rack-cors', require: 'rack/cors'
# gem "active_model_serializers", github: "rails-api/active_model_serializers"

# To use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

gem 'sidekiq'

# gem 'redis'###################I DON'T KNOW IF I NEED THIS######################

gem 'responders', '~> 2.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano', :group => :development

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :development do
  gem 'spring'
  gem 'better_errors'
  gem "binding_of_caller"
  gem "table_print"
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'capybara'
end

group :test do
  gem 'shoulda-matchers'
  gem 'simplecov', :require => false
end

group :production do
  gem 'rails_12factor'
  gem 'thin'
end
