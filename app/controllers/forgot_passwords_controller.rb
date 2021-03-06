class ForgotPasswordsController < ApplicationController
  
  def create
    user = User.find_by(email: params[:email])
    if user.present?
      AppMailer.send_forgot_password(user).deliver
      redirect_to forgot_password_confirmation_path
    else
      flash[:error] = params[:email].blank? ? "Email can't be blank." : "There is no user with that email in the system."
      redirect_to forgot_password_path
    end
  end

  def confirm
  end

  def expired_token
  end
end