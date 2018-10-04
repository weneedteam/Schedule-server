require 'uri'
require 'json'
require 'net/http'

module PushHelper

  URL_BASE = 'https://fcm.googleapis.com/fcm/send'.freeze
  CONTENT_TYPE = 'application/json'.freeze
  AUTHORIZATION = 'key=' + ENV['SCHEDULE_SERVER_FCM_KEY'].freeze

  def push(fcm_token, data)
    json_data = {
      to: fcm_token,
      data: data
    }

    url = URI.parse(URL_BASE)
    req = Net::HTTP::Post.new(url.path)

    req['Content-Type'] = CONTENT_TYPE
    req['Authorization'] = AUTHORIZATION
    req.body = json_data.to_json

    con = Net::HTTP.new(url.host, url.port)
    con.use_ssl = true
    con.start { |http| http.request(req) }
  end
end
