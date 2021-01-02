class CalendarsController < ApplicationController
  def index
    
    @calendar_data = "豚骨"
    gon.calendar_data = @calendar_data
  end

  def create
  end

  def update
  end
end
