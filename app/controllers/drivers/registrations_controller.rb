# frozen_string_literal: true

class Drivers::RegistrationsController < Devise::RegistrationsController
  # prepend_before_action :require_no_authentication, :only => [:create]
  # prepend_before_action :authenticate_driver!
  before_action :authenticate_driver!, :redirect_unless_admin,  only: [:new, :create]
  skip_before_action :require_no_authentication

  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end
def new
    build_resource({})
    resource.build_user_address
    respond_with self.resource
  end

  # POST /resource
  # def create
  #   super
  # end

  #  def create
  #   @resource = Driver.new(configure_sign_up_params)

  #   respond_to do |format|
  #     if @resource.save
  #       format.html { redirect_to drivers_path, notice: 'Driver was successfully created.' }
  #       format.json { render :show, status: :created, location: @resource }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @resource.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
# protected

#  def after_sign_up_path_for(resource)
#     'appointments_path' # Or :prefix_to_your_route
#   end

private

  def redirect_unless_admin
    unless current_user.try(:admin?)
      flash[:error] = "Only admins can do that"
      redirect_to drivers_path
    end
  end

  def sign_up(resource_name, resource)
    true
  end

    

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone_number, 
      :email, :password, :password_confirmation, :experience, :license_no, :location,
      user_address_attributes: %i(address_line1 address_line2 zipcode city state country)])
  end
end
