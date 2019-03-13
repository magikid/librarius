class SessionsController < ApplicationController
  def new
    redirect_to ''
  end

  def create
    auth_hash = request.env['omniauth.auth']

    @authorization = Authorization.find_by_provider_and_uid(auth_hash.provider, auth_hash.uid)
    if @authorization
        session[:user_id] = @authorization.user.id
        redirect_to root_path, notice: "Welcome back #{@authorization.user.name}! You have already signed up."
    else
      user = User.new name: auth_hash.info.nickname, email: auth_hash.info.email
      user.authorizations.build :provider => auth_hash.provider, :uid => auth_hash.uid
      user.save!

      session[:user_id] = user.id

      redirect_to root_path, notice: "Hi #{user.name}! You've signed up."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You're logged out"
  end

  def failure
  end
end
