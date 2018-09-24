class V1::SessionsController < Devise::SessionsController
    def create
        @user = User.where(email: params[:user][:email]).first
        if @user.valid_password?(params[:user][:password])
            @user.auth_token = Devise.friendly_token
            @user.save
        end
        render json: @user
    end

    def respond_with(resource, opts = {})
        if request.headers['Accept'] != 'application/json'
        # if request.method != 'POST'
            render json: { errors: 'Not supports.' }
        end
    end
end
