class V1::SessionsController < Devise::SessionsController
    def create
        @user = User.where(email: params[:user][:email]).first
        if !@user.nil?
            if @user.valid_password?(params[:user][:password])  
                @user.auth_token = Devise.friendly_token
                @user.save
                render json: @user
            else
                render json: {
                    code: 400, message: "The password is incorrect."
                }, status: 400
            end
        else
            render json: {
                code: 400, message: "The email is incorrect."
            }, status: 400
        end
    end

    def respond_with(resource, opts = {})
        if request.headers['Accept'] != 'application/json'
        # if request.method != 'POST'
            render json: {
                code: 406, message: "Not Acceptable, not supports."
            }, status: 406
        end
    end
end
