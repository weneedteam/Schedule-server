require 'uri'
require 'json'
require 'net/http'

module PushHelper
  URL_BASE = 'https://fcm.googleapis.com/fcm/send'.freeze

  def push(fcm_token, friend_id, user)
    json_data = {
      to: fcm_token,
      data: {
        user: {
          name: user.name,
          email: user.email,
          birth: user.birth.to_i,
          friend_id: friend_id
        }
      }
    }

    url = URI.parse(URL_BASE)
    req = Net::HTTP::Post.new(url.path)

    req['Content-Type'] = 'application/json'
    req['Authorization'] = 'key=' + ENV['SCHEDULE_SERVER_FCM_KEY']
    req.body = json_data.to_json

    con = Net::HTTP.new(url.host, url.port)
    con.use_ssl = true
    con.start { |http| http.request(req) }
  end
end
