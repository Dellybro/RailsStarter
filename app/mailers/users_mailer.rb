class UsersMailer < ApplicationMailer

  # Roadie rails allows for CSS and HTML to be used within the mailing system
	include Roadie::Rails::Automatic
  

  # Views will be found in app/views/user_mailer/~Method_Name
  # If need to create a new one create a .text.erb and a .html.erb.

  def account_activation(user)
    @user = user
    @url = "http://localhost:3000/activate_user?token=#{@user.activation_token}&email=#{@user.email}"

    mail to: user.email, subject: "Account activation"
  end

  
  def password_reset(user)
    @user = user
    @url = "http://localhost:3000/reset_user_password?user_id=#{@user.objectId}&token=#{@user.reset_token}"

    mail to: user.email, subject: "Reset Password - Start Project"
  end


end
