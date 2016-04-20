class SessionsController < ApplicationController

  def login
    @user = User.find_by_email(params[:email])
    if @user && @user.valid_password?(params[:password])
      sign_in(@user)
      view_string = render_to_string partial: 'home/welcome'
      render json: {success: true, welcome: view_string}
    else
      render json: {success: false}
    end
  end

end
