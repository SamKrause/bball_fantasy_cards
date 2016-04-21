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
    @playercards = current_user.playercards
    @playercard_arrays = generatePlayercardArrays(current_user.playercards)
    @first_pack = generatePlayercardArrays(generateFirstPack)
  end

  def generatePlayercardArrays(playercards)
    big_array = []
    small_array = []
    playercards.each do |player|
      if small_array.length < 5
        small_array.push(player)
      else
        big_array.push(small_array)
        small_array = []
        small_array.push(player)
      end
    end
    big_array.push(small_array)
    return big_array
  end

  def generateFirstPack
    card_array = []
    position_array = ["1B", "2B", "3B", "SS", "C"]
    position_array.each do |position|
      Playercard.where(:position => position).sample(3).each{|playercard| card_array.push(playercard)}
    end
    Playercard.where(:position => "OF").sample(9).each{|playercard| card_array.push(playercard)}
    Playercard.all.sample(1).each{|playercard| card_array.push(playercard)}
    return card_array
  end


  private

  def user_params
    params.permit(:email, :password, :password_confirmation, :team_name, :first_name, :last_name)
  end
end
