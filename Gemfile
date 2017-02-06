# Add extra mime Types
gem 'mime-types', require: 'mime/types/columnar'

source 'https://rubygems.org'

gem 'dotenv'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.3.13', '< 0.5'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Add CSS to emails
gem 'roadie-rails', '~> 1.0'
# Crypt password
gem 'bcrypt'
# Sendgrid
gem 'sendgrid'
# AWS
gem 'aws-sdk'
# Photo Storage
gem 'nokogiri'
gem 'fog' # 
# Kill puma workers
gem 'puma_worker_killer'
gem 'derailed'
gem "rack-timeout"

gem 'puma'

gem 'material_design_lite-rails', '~> 1.3'


group :production do 
	# Production gems only
end


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Dont really need this but we'll keep it in develpment
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

