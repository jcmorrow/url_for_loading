require 'bundler/setup'
require 'action_controller/railtie'

class TestApp < Rails::Application
  config.root = File.dirname(__FILE__)
  secrets.secret_token    = 'secret_token'
  secrets.secret_key_base = 'secret_key_base'

  config.logger = Logger.new($stdout)
  Rails.logger  = config.logger
end

class TestController < ActionController::Base
  def index
    render plain: 'Home'
  end
end

require 'minitest/autorun'
require 'rack/test'

class BugTest < ActionView::TestCase
  include Rails.application.routes.url_helpers

  def test_url_for_with_array
    puts method(:url_for).source_location

    assert_equal(url_for([:admin, :resource]), 'admin/resources/1')
  end

  private

  def app
    Rails.application
  end

  def admin_resource_path
    'admin/resources/1'
  end
end
