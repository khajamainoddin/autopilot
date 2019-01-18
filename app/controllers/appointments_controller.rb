class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]
  #before_action :set_driver
  #before_action :set_user
  after_action :verify_authorized, only: [:edit]

  # GET /appointments
  # GET /appointments.json
  def index
    if current_user.admin?
        @appointments = Appointment.all
      else
        @appointments = current_user.appointments
    end
  end

  def allocate
     @hello = "hello"
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show
    @driver = @appointment.driver.find(params[:driver_id])
    @user = @appointment.user.find(params[:user_id])
    #@appointment.driver.build
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new
  end

  # GET /appointments/1/edit
  def edit
    authorize @appointment
  end

  # POST /appointments
  # POST /appointments.json
  def create
    @appointment = current_user.appointments.new(appointment_params)

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to root_path, notice: 'Appointment was successfully created.' }
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html { render :new }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  def update
    respond_to do |format|
      if @appointment.update(appointment_params)
        format.html { redirect_to @appointment, notice: 'Appointment was successfully updated.' }
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to appointments_url, notice: 'Appointment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_driver
      @driver = Driver.find(params[:id])
    end

    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def appointment_params
      params.require(:appointment).permit(:vehicle_make, :vehicle_model, :schedule, :booked, :status, :user_id, :driver_id)
    end
end
