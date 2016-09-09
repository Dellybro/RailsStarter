class StaticController < ApplicationController



  def index
    @noTopNav = true
  end

  def about
  end

  def contact
  end

  def server_path
  end

  def sign_up
  	if request.get?
  		@user = User.new
  	elsif request.post?
  		# Create user validation method here
  		@user = User.create(user_params)
  		if @user.id
        # Send activation Link sets new Activation token (temporary) and sets an activation digest, which is a crypted version of the token
        # Once set, it send an email, with a link to activate the user. The activation digest once set, can only be decrypted using the token
        # The token vanishes from the User once it's deallocated
        @user.sendActivationLink()
  			flash[:success] = [AlertMessage.new(:message_title => "Signup Successful", :message => "Email Sent to your Inbox for Verification")]
	  		redirect_to sign_in_path
  		else
  			flash[:warning] = get_toastr_errors(@user)
	  		redirect_to sign_up_path
  		end
  	end
  end

  def sign_in
  	if request.get?
  		# Continue forward
  	elsif request.post?
      # Login user
      @user = User.find_by(:email => params[:session][:email])
      if @user && User.authenticate(params[:session][:email], params[:session][:password])
        if @user.activated
          log_in_user @user
          flash[:success] = [AlertMessage.new(:message_title => "Signin Success!", :message => "Thanks for logging in, #{@user.first_name}!")]
          redirect_to user_index_path
        else
          flash[:warning] = [AlertMessage.new(:message_title => "Signin Failure", :message => "You are not activated! Check your inbox for link")]
          redirect_to sign_in_path
        end
      else
        flash[:warning] = [AlertMessage.new(:message_title => "Signin Failure", :message => "Email/Password Combination invalid")]
        redirect_to sign_in_path
      end
  	end
  end


  private
  	def  user_params
  		params.require(:user).permit(:first_name, :last_name, :email, :password)
  	end
  
end
