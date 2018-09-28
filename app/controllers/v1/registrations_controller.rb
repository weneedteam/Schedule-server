class V1::RegistrationsController < Devise::RegistrationsController
    respond_to :json

    def respond_with(resource, opts = {})
        if request.headers['Accept'] != 'application/json'
        # if request.method != 'POST'
            render json: {
                message: { code: 406, message: "Not Acceptable, not supports." }
            }, status: 406
        else 
            if resource.id.nil?
                render json: { 
                    message: { code: 400, message: resource.errors.full_messages }
                }, status: 400
            else
                render json: resource
            end
        end
    end

    private

    def sign_up_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :phone, :birth)
    end

    def account_update_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :phone, :birth, :current_password)
    end
end
