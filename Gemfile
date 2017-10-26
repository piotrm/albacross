source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'
gem 'mysql2'
gem 'native_enum', git: "https://github.com/piotrm/native_enum.git"
gem 'composite_primary_keys'
gem 'active_model_serializers'
gem 'will_paginate'
gem 'input_sanitizer', git: 'https://github.com/futuresimple/input_sanitizer.git', tag: '0.3.26'
gem 'elasticsearch-rails'
gem 'elasticsearch-model'
gem 'puma', '~> 3.7'

group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'database_cleaner'
end

group :development, :test do
  gem 'pry'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

ruby "2.4.2"