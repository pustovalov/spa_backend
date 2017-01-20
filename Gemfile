source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.0'

gem 'knock'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors', require: 'rack/cors'
gem 'figaro'
gem 'kaminari'
gem 'pg_search'
gem 'fog-aws'
gem 'carrierwave', '>= 1.0.0.rc', '< 2.0'
gem 'carrierwave-base64'
gem 'mini_magick'
gem 'http_accept_language'

gem 'bugsnag'

group :production do
  gem 'newrelic_rpm'
end

group :development, :test do
  gem 'binding_of_caller'
  gem "better_errors"
  gem 'rspec-rails'
  gem 'capybara'
  gem 'poltergeist'
  gem 'factory_girl_rails'
  gem 'parallel_tests'
  gem 'database_cleaner'
  gem 'faker'

  gem 'pry-byebug'
  gem 'awesome_print', require:'ap'
end

group :development do
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'capistrano', '~> 3.6'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-bundler'
  gem 'capistrano-rbenv'
  gem 'capistrano3-puma', github: "seuros/capistrano-puma"
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
