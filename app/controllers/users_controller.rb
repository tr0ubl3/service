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
#   # GET /resource/sign_up
#   def new
#     @machine_owners = MachineOwner.all
#     build_resource({})
#     respond_with self.resource
#   end

#   def new_user_by_admin
#     @user = User.new
#   end

#   def new_admin
#     @admin = User.new
#   end

#   def create_user_by_admin
#     @generated_password = Devise.friendly_token.first(8)
#     @user = User.new(params[:user])
#     @user.password = @generated_password
#     if @user.save
#       redirect_to manage_users_path, notice: 'Regular user was successfully created.'
#     else
#       clean_up_passwords resource
#       render "new_user_by_admin"
#     end
#   end

#   def create_admin
#     @generated_password = Devise.friendly_token.first(8)
#     @admin = User.new(params[:user])
#     @admin.admin = true
#     @admin.password = @generated_password
#     @admin.machine_owner_id = 1
#     if @admin.save
#       redirect_to manage_users_path, notice: 'Admin user was successfully created.'
#     else
#       clean_up_passwords resource
#       render "new_admin"
#     end
#   end

#   # POST /resource
#   def create
#     @machine_owners = MachineOwner.all
#     build_resource(sign_up_params)

#     if resource.save
#       yield resource if block_given?
#       if resource.active_for_authentication?
#         set_flash_message :notice, :signed_up if is_flashing_format?
#         sign_up(resource_name, resource)
#         respond_with resource, :location => after_sign_up_path_for(resource)
#       else
#         set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
#         expire_data_after_sign_in!
#         respond_with resource, :location => after_inactive_sign_up_path_for(resource)
#       end
#     else
#       clean_up_passwords resource
#       respond_with resource
#     end
#   end

#   # GET /resource/edit
#   def edit
#     render :edit
#   end

#   # PUT /resource
#   # We need to use a copy of the resource because we don't want to change
#   # the current user in place.
#   def update
#     self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
#     prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

#     if update_resource(resource, account_update_params)
#       yield resource if block_given?
#       if is_flashing_format?
#         flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
#           :update_needs_confirmation : :updated
#         set_flash_message :notice, flash_key
#       end
#       sign_in resource_name, resource, :bypass => true
#       respond_with resource, :location => after_update_path_for(resource)
#     else
#       clean_up_passwords resource
#       respond_with resource
#     end
#   end

#   # DELETE /resource
#   def destroy
#     resource.destroy
#     Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
#     set_flash_message :notice, :destroyed if is_flashing_format?
#     yield resource if block_given?
#     respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
#   end

#   # GET /resource/cancel
#   # Forces the session data which is usually expired after sign
#   # in to be expired now. This is useful if the user wants to
#   # cancel oauth signing in/up in the middle of the process,
#   # removing all OAuth session data.
#   def cancel
#     expire_data_after_sign_in!
#     redirect_to new_registration_path(resource_name)
#   end

#   protected

#   def update_needs_confirmation?(resource, previous)
#     resource.respond_to?(:pending_reconfirmation?) &&
#       resource.pending_reconfirmation? &&
#       previous != resource.unconfirmed_email
#   end

#   # By default we want to require a password checks on update.
#   # You can overwrite this method in your own RegistrationsController.
#   def update_resource(resource, params)
#     resource.update_with_password(params)
#   end

#   # Build a devise resource passing in the session. Useful to move
#   # temporary session data to the newly created user.
#   def build_resource(hash=nil)
#     self.resource = resource_class.new_with_session(hash || {}, session)
#   end

#   # Signs in a user on sign up. You can overwrite this method in your own
#   # RegistrationsController.
#   def sign_up(resource_name, resource)
#     sign_in(resource_name, resource)
#   end

#   # The path used after sign up. You need to overwrite this method
#   # in your own RegistrationsController.
#   def after_sign_up_path_for(resource)
#     after_sign_in_path_for(resource)
#   end

#   # The path used after sign up for inactive accounts. You need to overwrite
#   # this method in your own RegistrationsController.
#   def after_inactive_sign_up_path_for(resource)
#     respond_to?(:root_path) ? root_path : "/"
#   end

#   # The default url to be used after updating a resource. You need to overwrite
#   # this method in your own RegistrationsController.
#   def after_update_path_for(resource)
#     signed_in_root_path(resource)
#   end

#   # Authenticates the current scope and gets the current resource from the session.
#   def authenticate_scope!
#     send(:"authenticate_#{resource_name}!", :force => true)
#     self.resource = send(:"current_#{resource_name}")
#   end

#   def sign_up_params
#     devise_parameter_sanitizer.sanitize(:sign_up)
#   end

#   def account_update_params
#     devise_parameter_sanitizer.sanitize(:account_update)
#   end

#   private
#   def require_no_authentication_for_admin
#     if current_user.present? && current_user.admin? == false
#     	require_no_authentication
#     end
#   end
end