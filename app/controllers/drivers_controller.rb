class DriversController < ApplicationController
  def index
  	@drivers = Driver.all
  end

  # def allocate
  # 	@hello = "Hello"
  # end
end
