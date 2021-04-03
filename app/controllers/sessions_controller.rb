class SessionsController < Devise::SessionsController
    before_action :sign_in_params, only: :create
    before_action :load_user, only: :create
    before_action :valid_token, only: :destory
    skip_before_action :verify_signed_out_user, only: :destory

    #sign_in
    def create
        if @user.valid_password?(sign_in_params[:password])
            sign_in "user", @user
            json_response "Signed In successful", true, {user: @user}, :ok
            
        
        else
            json_response "Unauthorized", false, {}, :unauthorized
            
        end

    end

    #sign out
    def destory
        sign_out @user
        @user.generate_new_authentication_token
        render json: {
            messages: "Log out Successfully",
            is_success: true,
            data: {}

        }, status: :ok
        
        
    end


    private
    def sign_in_params
        params.require(:sign_in).permit(:email, :password)
    end

    def load_user
        @user = User.find_for_authentication(email: sign_in_params[:email])
        if @user
            return @user
        else
            
            json_response "Cannot get User", false, {}, :failure
        end
    end

    def valid_token
        @user = User.find_by authentication_token: request.headers["AUTH-TOKEN"]
        if @user
            return @user
        else
            render json: {
                messages: "Invalid Token",
                is_success: false,
                data: {}
            }, status: 417
        end
    end
            

end