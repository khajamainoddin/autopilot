class CustomersController < ApplicationController
	before_action :set_appointment, only: [:show]

  def index
  	@user = User.all
  end

  def show
	  
  end
  
  def allocate
  	render :allocate
  end


  private

  def set_customer
      @user = User.find(params[:id])
      @appointment = Appointment.find(params[:id])
  end

  def customer_params
      params.require(:customer).permit(:first_name, :last_name, 
        :phone_number, user_address_attributes: %i(address_line1 address_line2 zipcode city state country))
  end

end
