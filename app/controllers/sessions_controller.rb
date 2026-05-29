class SessionsController < ApplicationController
  def new
   
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      forwarding_url = session[:forwarding_url]
      reset_session      # ログインの直前に必ずこれを書くこと
      # 下記は第9章による追加か？入れるとエラーになる（リスト10.33）
      # params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      log_in user
      redirect_to forwarding_url || user
    else
      flash.now[:danger] = 'Invalid email/password combination' # 本当は正しくない
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    redirect_to root_url, status: :see_other
  end
end
