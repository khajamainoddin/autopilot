class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia
  
  # attr_accessor :email
  # attr_accessor :current_password
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  ## Database authenticatable
  field :first_name, type: String
  field :last_name, type: String
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""
  field :phone_number

  embeds_one :user_address, class_name: 'Address', as: :addressable, validate: false
  accepts_nested_attributes_for :user_address
  field :_roles, type: Hash, default: { user: true }
  field :active, type: Boolean, default: true
  field :deleted_at, type: Time, default: nil

  scope :active, -> { where(active: true, deleted_at: nil) }

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  # field :sign_in_count,      type: Integer, default: 0
  # field :current_sign_in_at, type: Time
  # field :last_sign_in_at,    type: Time
  # field :current_sign_in_ip, type: String
  # field :last_sign_in_ip,    type: String

  ## Confirmable
  field :confirmation_token,   type: String
  field :confirmed_at,         type: Time
  field :confirmation_sent_at, type: Time
  field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time


  def role?(role)
    _roles[role.to_s] || false
  end

  def admin?
    role?(:admin)
  end


  has_many :appointments


  def appoint_drivers
    Driver.in(id: appointments.pluck(:driver_id))
  end
end
