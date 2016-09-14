require 'sidekiq'
require 'sidekiq/api'
require 'sidekiq/web'
require 'sidekiq-scheduler/web'
Sidekiq.configure_client do |config|
  config.redis = { :size => 1 }
end

Sidekiq.configure_server do |config|
  config.redis = { :size => 4 }
end
