json.extract! appointment, :id, :vehicle_make, :vehicle_model, :schedule_time, :booked_time, :status, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)
