class UsersController < ApplicationController
  def signup
    @user = User.create(user_params)
    sign_in(:user, @user)

    if @user.valid?
      view_string = render_to_string partial: 'home/welcome'
      render json: {success: true, welcome: view_string}
    else
      render json: {success: false, errors: @user.errors.full_messages}
    end
  end

  def profile
    @playercards = User.find(1).playercards
  end

  def playercards
    @playercards = User.find(1).playercards

    view_string = render_to_string partial: 'users/playercards'
    render json: {success: true, questions: view_string}
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation, :team_name, :first_name, :last_name)
  end
end
