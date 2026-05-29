require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest

def setup
    # 💡 【演習10.3.1】データベースの最初のユーザーを確実に取得する（いなければ新しく作る）
    @user = User.first || User.create!(name: "Rails Tutorial", 
                                       email: "example@railstutorial.org", 
                                       password: "foobar", 
                                       password_confirmation: "foobar")
  end

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    get contact_path
    assert_select "title", full_title("Contact")
    get signup_path
    assert_select "title", full_title("Sign up")
  end

  # 【演習10.3.1】ログイン済みユーザーのリンクテスト
  test "layout links when logged in" do
    log_in_as(@user) # ログイン状態にする
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    
    # ログイン後に表示されるべきリンクの検証
    assert_select "a[href=?]", users_path            # ユーザー一覧
    assert_select "a[href=?]", user_path(@user)      # プロフィール
    assert_select "a[href=?]", edit_user_path(@user) # 設定 (Settings)
    assert_select "a[href=?]", logout_path           # ログアウト

    # ログイン後は表示されないはずのリンクの検証
    assert_select "a[href=?]", login_path, count: 0
  end

end
