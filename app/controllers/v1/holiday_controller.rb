class V1::HolidayController < ApplicationController
    include HolidayHelper

    def index
        year = params[:year].to_i
        unless year.nil?
            @prev_holidays = Holiday.where(year: year - 1)
            if @prev_holidays.size == 0
                req_holidays = getHoliday(year - 1)
                for req_holiday in req_holidays['results']
                    holiday = Holiday.new
                    holiday.name  = req_holiday['name']
                    holiday.year  = req_holiday['year']
                    holiday.month = req_holiday['month']
                    holiday.day   = req_holiday['day']
                    holiday.save!
                end
            end

            @holidays = Holiday.where(year: year)
            if @holidays.size == 0
                req_holidays = getHoliday(year)
                for req_holiday in req_holidays['results']
                    holiday = Holiday.new
                    holiday.name  = req_holiday['name']
                    holiday.year  = req_holiday['year']
                    holiday.month = req_holiday['month']
                    holiday.day   = req_holiday['day']
                    holiday.save!
                end
            end

            @next_holidays = Holiday.where(year: year + 1)
            if @next_holidays.size == 0
                req_holidays = getHoliday(year + 1)
                for req_holiday in req_holidays['results']
                    holiday = Holiday.new
                    holiday.name  = req_holiday['name']
                    holiday.year  = req_holiday['year']
                    holiday.month = req_holiday['month']
                    holiday.day   = req_holiday['day']
                    holiday.save!
                end
            end

            @holidays = Holiday.where(year: year - 1..year + 1).order(:year)
        else
            @holidays = nil
        end
        render json: @holidays
    end

    def search (year)
    end
end
