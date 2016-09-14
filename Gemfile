source 'https://rubygems.org'
ruby '2.3.1'

gem 'rails', '~> 5.0.0'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'sassc-rails', github: 'sass/sassc-rails'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'redis', '~> 3.0'
gem 'sidekiq'
gem 'sidekiq-scheduler'
gem 'haml'
gem 'haml-rails'
gem 'bootstrap', '~> 4.0.0.alpha3.1'
gem 'rails_12factor'
gem 'sinatra', git: 'https://github.com/sinatra/sinatra', :require => nil
gem 'gon'
gem 'devise'
gem 'activeadmin', github: 'activeadmin/activeadmin'
gem 'inherited_resources', github: 'activeadmin/inherited_resources'
gem 'faker'
gem "font-awesome-rails"

source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.1.0'
end

group :development, :test do
  gem 'byebug', platform: :mri
end

group :development do
  gem 'foreman'
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
