module UserHelper

    def checkUser(request)
        token = request.headers['Authorization']
        user = User.where(auth_token: token).first unless token.nil?
        return user.nil? ? nil : user
    end
end