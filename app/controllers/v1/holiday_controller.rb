class V1::HolidayController < ApplicationController
    def index
        @holiday = Holiday.all
    end
end
