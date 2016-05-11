source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

gem 'rake'

gem 'haml-rails'

gem 'devise'

gem 'bootstrap-sass'

gem 'simple_form'

gem 'axlsx_rails'
gem 'axlsx', '~> 2.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'better_errors'
gem 'binding_of_caller'

gem 'bootstrap-datepicker-rails'

gem 'bootstrap-timepicker-rails'

gem 'jquery-timepicker-rails'

gem 'dotiw' # Better distance of time ago in words

gem 'faker'

gem 'will_paginate'

gem 'react-rails'

gem 'pdfkit'

gem 'wkhtmltopdf-binary'



# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
group :production do
  gem 'pg'
end

group :test do
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'rspec-rails'
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'

  # Use the RVM Capistrano gem to help use the proper version of ruby with deployment
  gem 'capistrano', '3.4.0'
  gem 'capistrano-rails', '1.1.6'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end
