class V1::HolidayController < ApplicationController
  include HolidayHelper

  def index
    year = params[:year].to_i
    unless year.nil?
      @holidays = Holiday.where(year: year)
      if @holidays.size == 0
        req_holidays = getHoliday(year)
        for req_holiday in req_holidays['results']
          holiday = Holiday.new
          holiday.name = req_holiday['name']
          holiday.year = req_holiday['year']
          holiday.month = req_holiday['month']
          holiday.day = req_holiday['day']
          holiday.save!
        end
      end
      @holidays = Holiday.where(year: year).order(:year)
    else
      @holidays = nil
    end
    render json: @holidays
  end

  def search (year)
  end
end
