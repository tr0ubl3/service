class UsersController < ApplicationController

  layout 'user', only: [:new, :create, :login]
  before_filter :check_auth, except: [:new, :create, :login]
  before_filter :check_admin, only: [:approve, :cp_new, :cp_create, :new_admin, :create_admin]

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
end