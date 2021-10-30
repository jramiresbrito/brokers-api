source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.0.4', '>= 6.0.4.1'
# Use Puma as the app server
gem 'puma', '~> 4.1'

# Rendering
gem 'jbuilder', '~> 2.7'
gem 'active_model_serializers'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Authentication
gem 'bcrypt', '~> 3.1.7'
gem 'jwt'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# CLI helpers
gem 'colorize'

# Cross-Origin Resource Sharing (CORS), make cross-origin AJAX possible
gem 'rack-cors'

# MongoDB & MongoID
gem 'mongo', '~> 2.6.4'
gem 'mongoid', '>= 6.4'
# gem 'mongoid_rails_migrations'

# Pagination
gem 'kaminari-mongoid'

# PubSub
gem 'wisper'

# RabbitMQ
gem 'hutch'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'faker'
  gem 'mailcatcher'
end

group :development do
  gem 'listen', '~> 3.2'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
