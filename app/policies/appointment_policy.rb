class AppointmentPolicy < ApplicationPolicy
	def index?
		user.role == 'admin' || record.user == user		
	end
	def show?
		user.admin?
	end
	# def update?
	# 	user.admin?
	# end

	# def edit?
	# 	user.admin?
	# end
  class Scope < Scope
    def resolve
      #scope.all
    end
  end
end
