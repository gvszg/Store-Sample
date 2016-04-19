source 'https://rubygems.org'
ruby '2.2.4'
# if ENV["RAILS_ENV"] == "development"
#   ruby '2.2.2'
# elsif ENV["RAILS_ENV"] == "production" || ENV["RAILS_ENV"] == "staging"
#   ruby '2.2.4'
# end

# Use Unicorn as the app server
gem 'unicorn'

gem 'rails', '4.2.5'
gem 'mysql2', '>= 0.3.13', '< 0.5'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'turbolinks'
gem 'bootstrap-sass'
gem "font-awesome-rails"
gem "paranoia", "~> 2.0" # 軟刪除
gem 'carrierwave', github: 'carrierwaveuploader/carrierwave'
gem 'mini_magick'
gem 'ckeditor'
gem 'will_paginate', '~> 3.0.5'
gem "jquery-fileupload-rails"
gem 'bcrypt', '~> 3.1.7'
gem 'gcm'


gem 'fog'
# For carawl cvs data setup
gem 'nokogiri'
# gem 'therubyracer'
gem 'rspec-rails'
gem 'capybara'
gem 'selenium-webdriver'
# For credential data
gem "figaro"
group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem 'meta_request'
  gem 'faker'
  gem 'pry-rails'

  # 檢查安全性
  gem 'brakeman', :require => false

  # 檢查 N+1 Query
  gem 'bullet'

  # 靜態分析程式碼(已整合多套工具)
  gem 'rubycritic', :require => false

  # 監測網站效能
  gem 'newrelic_rpm'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano-rbenv'
  gem 'capistrano-sidekiq'
  gem 'guard-livereload', '~> 2.5', require: false
end
