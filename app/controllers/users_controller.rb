class UsersController < ApplicationController

  layout 'user', only: [:new, :create, :login]
  before_filter :check_auth, only: [:show, :approve_user]

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

  def approve_user
    @user = User.find(params[:id])
    redirect_to user_path(@user)
    if params[:approved]
      @user.update_attributes(approved_at: Time.now)
      flash[:notice] = 'User registration is approved'
      UserMailer.user_registration_approved(@user).deliver
      UserMailer.user_registration_approved_to_admin(@user, current_user).deliver
    else
      @user.update_attributes(denied_at: Time.now)
      flash[:alert] = "#{@user.full_name} registration it's denied"
      UserMailer.user_registration_denied(@user).deliver
    end
  end

  def cp_new
    @user = User.new
    @machine_owners = MachineOwner.all
  end

  def cp_create
    @user = User.new(params[:user])
    @user.password = rand(36**8).to_s(36)
    @user.save
    render nothing: true
  end
end