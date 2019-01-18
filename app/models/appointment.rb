class Appointment

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia
  include Mongoid::Enum

  enum :status, [:pending, :allocated, :inprogress, :completed]
  

  #after_create :create_default_vehicles
  #after_create :create_default_models

  field :vehicle_make, type: String
  field :vehicle_model, type: String
  field :schedule, :type => Date
  field :booked, :type => Time
  field :status, type: String, default: ->{ 'Pending' }
  field :deleted_at, type: Time, default: nil

  scope :active, -> { where(active: true, deleted_at: nil) }

  embeds_one :user_address, class_name: 'Address', as: :addressable, validate: false
  accepts_nested_attributes_for :user_address

  belongs_to :user
  belongs_to :driver, optional: true

  validates :vehicle_make, presence: true
  validates :vehicle_model, presence: true
  validates :schedule, presence: true
  validates :booked, presence: true

  # def destroy
  #   update(deleted_at: Time.current)
  # end

  def status_label
     {
       'pending' => 'pending approval',
       'allocated' => 'Vehicle Allocated to driver',
       'inprogress' => 'Service is inprogress',
       'completed' => 'service is completed'
     }[self.status]
  end

  private

  def create_default_vehicles
    %w(Car Bike Others).each do |name|
      vehicle_make.create(vehicle_make: name)
    end
  end

  def create_default_models
      %w(Swift Skoda Benz others).each do |name|
        vehicle_model.create(vehicle_model: name)
      end
  end

  def appoint_drivers
    Driver.in(id: appointments.pluck(:driver_id))
  end

end
