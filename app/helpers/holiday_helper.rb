require 'net/http'
require 'json'

module HolidayHelper

    URL_BASE = 'https://apis.sktelecom.com/v1/eventday/days?type=h&year='

    def getHoliday(year)
        uri = URI(URL_BASE + year)
        req = Net::HTTP::Get.new(uri)
        req['Content-Type'] = 'application/json'
        req['TDCProjectKey'] = ENV['SCHEDULE_SERVER_SKT_API_KEY']
        
        res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true) {|http|
          http.request(req)
        }
        
        return JSON.parse(res.body)
    end
end