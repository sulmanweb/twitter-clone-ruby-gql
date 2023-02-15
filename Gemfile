source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.0'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.4', '>= 7.0.4.2'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.4', '>= 1.4.5'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 6.1'

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem 'bcrypt', '~> 3.1', '>= 3.1.18'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem 'image_processing', '~> 1.12', '>= 1.12.2'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors', '~> 2.0'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'annotate'
  gem 'bullet'
  gem 'debug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'rubocop', require: false
  gem 'rubocop-graphql', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end

group :test do
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'timecop'
end

gem 'factory_bot_rails', '~> 6.2'
gem 'faker', '~> 3.1', '>= 3.1.1'

gem 'apollo_upload_server', '~> 2.1', '>= 2.1.5'
gem 'graphiql-rails', github: 'spicotech/graphiql-rails'
gem 'graphql', '~> 2.0', '>= 2.0.17'
gem 'graphql-rails_logger', '~> 1.2', '>= 1.2.4'
gem 'sass-rails', '~> 6.0'
