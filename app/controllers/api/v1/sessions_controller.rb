class Api::V1::SessionsController < ApplicationController
	def create

    user_password = params[:password]
    user_email = params[:email]
    user = user_email.present? && User.find_by(email: user_email)
 # debugger
    if user.valid_password? user_password
      sign_in user, store: false
      user.generate_authentication_token!
      user.save
      render json: {status: 1,responseMessage: "User find Successfully"}
    else
      render json: { errors: "Invalid email or password" }, status: 422
    end
  end
   def destroy
    user = User.find_by(id: params[:id])
    user.generate_authentication_token!
    user.save
    head 204
  end
  
end