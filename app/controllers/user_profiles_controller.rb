class UserProfilesController < ApplicationController
    before_action :authenticate_user!
    def index 
        @userprofile = User_profile.all

    end

    def show 
        render json: User_profile.find(params[:id])
    end


    def new 
        @userprofile = User_profile.new(user: current_user)
        
    end

    def Update 
        @userprofile = current_user.User_profile.build(filtered_params)
        if @userprofile.save
            json_response "User update successful", true, {user_profile: @userprofile}, :ok
        else
            render new
        end

    end


    private
    
    def filtered_params
        params.require(:user_profile).permit(:studentno, :fname, :mname, :lname, :user_id)
    end
end
