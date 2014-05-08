class UsersController < ApplicationController

  layout 'user', only: [:new, :create, :login, :new_password_reset, 
                        :create_password_reset, :edit_password_reset,
                        :save_password_reset]
  before_filter :check_auth, except: [:new, :create, :login, :confirm,
                                      :new_password_reset, :create_password_reset,
                                      :edit_password_reset, :save_password_reset]
  before_filter :check_admin, only: [:approve, :cp_new, :cp_create, :new_admin, 
                                     :create_admin]

  def index
    @users = User.all
    respond_to do |format|
        format.html # index.html.erb
        format.json { render json: UserJdts.new(view_context) }
    end
  end

  def new
    @user = User.new
    @machine_owners = MachineOwner.all
  end

  def create
  	@user = User.new(params[:user])
    @machine_owners = MachineOwner.all
    admins = User.where(:admin => true)
  	if @user.save
    	redirect_to login_path, notice: 'You successfully submit registration'
    	UserMailer.confirmation(@user).deliver
      UserMailer.approval(admins, @user).deliver
    else
      flash.now[:error] = 'Please correct errors and try again!'
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def approve
    @user = User.find(params[:id])
    if params[:approve] == "true"
      @user.update_attribute(:approved_at, Time.now)
      @user.update_attribute(:denied_at, nil)
      flash[:notice] = "#{@user.full_name} registration is approved"
      UserMailer.user_registration_approved(@user).deliver
      UserMailer.user_registration_approved_to_admin(@user, current_user).deliver
      redirect_to user_path(@user)
    else
      @user.update_attribute(:denied_at, Time.now)
      @user.update_attribute(:approved_at, nil)
      flash[:alert] = "#{@user.full_name} registration it's denied"
      UserMailer.user_registration_denied(@user).deliver
      redirect_to user_path(@user)
    end
  end

  def cp_new
    @user = User.new
    @machine_owners = MachineOwner.all
  end

  def cp_create
    @user = User.new(params[:user])
    @machine_owners = MachineOwner.all
    @user.password = rand(36**8).to_s(36)
    @user.approved_at = Time.now
    @user.confirmed = true
    @user.admin_id = current_user.id if current_user.admin?
    if @user.save
      redirect_to manage_users_path, notice: "You successfully created user #{@user.full_name}"
      UserMailer.invitation(@user).deliver
      UserMailer.invitation_to_admin(@user, current_user).deliver
    else
      flash.now[:error] = 'Invalid form values'
      render :cp_new
    end
  end

  def new_admin
    @admin = User.new
  end

  def create_admin
    @admin = User.new(params[:user])
    @admin.password = rand(36**8).to_s(36)
    @admin.approved_at = Time.now
    @admin.firm_id = Firm.where(:type => "AuthorizedReseller").first.id
    @admin.admin = true
    @admin.confirmed = true
    @admin.admin_id = current_user.id if current_user.admin?
    if @admin.save
      redirect_to manage_users_path
      flash[:notice] = "You successfully registered admin user #{@admin.full_name}"
      UserMailer.admin_invitation(@admin).deliver
      UserMailer.confirmation_for_admin(@admin, current_user).deliver
    else
      flash.now[:error] = 'Invalid form values'
      render :new_admin
    end
  end

  def confirm
    @user = User.find_by_auth_token(params[:token])
    @user.update_attribute(:confirmed, true)
    redirect_to login_path
    flash[:notice] = "You successfully confirmed your account, you can now login into application"
  end

  def new_password_reset
    
  end

  def create_password_reset
    @user = User.find_by_email(params[:email])
    if @user
      @user.update_attribute(:password_reset_token, @user.generate_token(:password_reset_token))
      @user.update_attribute(:password_reset_sent_at, Time.now)
      UserMailer.password_reset_instructions(@user).deliver
      redirect_to login_path, :notice => "Email sent with password reset instructions."
    else
      flash.now[:alert] = "Entered email was not found!"
      render :new_password_reset
    end
  end

  def edit_password_reset
    check_user = User.find_by_password_reset_token(params[:token])
    if check_user != nil
      if check_user.password_reset_sent_at < 2.hours.ago
        redirect_to new_password_reset_users_path
        flash[:alert] = 'Password reset link has expired'
      else
        @user = check_user
      end
    else
      flash[:error] = "Oops, url not valid!"
      redirect_to login_path
    end
  end

  def save_password_reset
    @user = User.find_by_password_reset_token(params[:token])
    if @user.update_attributes(params[:user])
      redirect_to login_path
      flash[:notice] = "Your password has been reseted, you can login with new credentials"
    else
      flash[:error] = 'Please correct form errors!'
      render :edit_password_reset
    end
  end

  def edit
    @user = current_user
  end 

  def update
    @user = User.find(params[:id])
    if @user.authenticate(params[:user][:current_password])
      @user.assign_attributes(params[:user])
      
      count_errors = 0
      errors = proc do
        count_errors += 1
      end

      count_updated = 0
      updated = proc do
        count_updated += 1
      end

      update_success = proc do
        flash[:notice] = "You successfully updated your account"
        redirect_to root_path
      end

      update_error = proc do
        flash[:error] = "Please correct errors"
        render :edit
      end

      case @user
      when lambda(&:email_changed?)
        update_email = proc do
          @user.update_attribute(:confirmed, false) && 
          @user.update_attribute(:email, @user.email) &&
          @user.update_attribute(:auth_token, @user.generate_token(:auth_token))
            # UserMailer.email_change(@user).deliver
          end
          @user.valid?
          if @user.errors[:email].empty?
            update_email.call
            updated.call
          else
            errors.call
          end

        when lambda(&:phone_number_changed?)
          update_phone = proc do
            @user.update_attribute(:phone_number, @user.phone_number)
          end
          @user.valid?
          if @user.errors[:phone_number].empty?
            update_phone.call
            updated.call
          else
            errors.call
          end

        when Proc.new {@user.password != '' || @user.password_confirmation != ''}
          if @user.update_attributes(params[:user])
            updated.call
          else
            errors.call
          end
        else
          flash[:error] = "Nothing to change"
          render :edit
        end
        
        if count_errors > 0 && count_updated == 0
          @user.errors.delete(:password) unless !@user.password.empty? || !@user.password_confirmation.empty?
          update_error.call
        elsif count_errors == 0 && count_updated  > 0
          update_success.call
        end
      else
        flash.now[:alert] = "Invalid current password!"
        render :edit
      end
    end
end