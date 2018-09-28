class V1::PasswordsController < Devise::PasswordsController
    def respond_with(resource, opts = {}) 
        if request.headers['Accept'] != 'application/json'
        # if request.method != 'POST'
            render json: {
                result: { code: 406, message: "Not Acceptable, not supports." }
            }, status: 406
        end
    end
end
