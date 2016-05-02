# config/initializers/pusher.rb
require 'pusher'

Pusher.app_id = '202482'
Pusher.key = 'fc4ded0fd159951bdc56'
Pusher.secret = '7d3f426660347ae723fd'
Pusher.logger = Rails.logger
Pusher.encrypted = true
