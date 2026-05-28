ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  include ApplicationHelper

  # テストユーザーがログイン中の場合にtrueを返す
  def is_logged_in?
    !session[:user_id].nil?
  end

 #第9章での追加記述。今回は履修外なので個別追記
  def log_in_as(user)
    session[:user_id] = user.id
  end

  # Add more helper methods to be used by all tests here...
end

 #第9章での追加記述。今回は履修外なので個別追記
class ActionDispatch::IntegrationTest

  # 統合テスト（Integration Test）用の log_in_as
  def log_in_as(user, password: 'password', remember_me: '1')
    post login_path, params: { session: { email: user.email,
                                          password: password,
                                          remember_me: remember_me } }
  end
end