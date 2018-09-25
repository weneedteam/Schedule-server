class V1::PasswordsController < Devise::PasswordsController
    def respond_with(resource, opts = {})
        puts request.headers['Accept'] != 'application/json' 
        if request.headers['Accept'] != 'application/json'
        # if request.method != 'POST'
            render json: { errors: 'Not supports.' }
        end
    end
end
