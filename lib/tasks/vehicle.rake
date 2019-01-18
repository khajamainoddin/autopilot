# frozen_string_literal: true
require 'csv'
# namespace :vehicle do
# 	desc 'Update Vehicle Details'
# 	task :appointment_details, %i(vehicle_make vehicle_model status ) => :environment do |t, args|
# 		appointment = Appointment.new(vehicle_make: args[:vehicle_make], 
# 			vehicle_model: args[:vehicle_model], status: args[:status])

# 		appointment.save
# 		puts appointment.errors.inspect
# 	end
# end

namespace :vehicle do
	desc 'Update Vehicle Details'

	task :seeds
end