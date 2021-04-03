class ActivitiesController < ApplicationController
    before_action :set_activity, only: [:edit, :update, :show, :destory]
    def index
        authorize @activity
        @activities = Activity.all
    end

    def new
        authorize @activity
        @activity = Activity.new
    end


    def show 
        authorize @activity
        render json: Activity.find(params[:id])
    end

    def create 
        authorize @activity
        activity = Activity.new(activity_params)
        if activity.save
            json_response "activity created", true, {activity: @activity}, :created 
            #render json:{}activity, status: :created
        else
            render 'new'
        end
    end

    def edit
        
        authorize @activity
        @activity = Activity.find(params[:id])
    end

    def update 
        authorize @activity
        @activity = Activity.find(params[:id])
        if @activity.update(activity_params)
            json_response "Update successful", true, {activity: @activity}, :ok
        else
            render 'edit'
        end
    end
    #def show
    #    @activity = Activity.find(params[:id])
    #nd

    def destory
        authorize @activity
        @activity = Activity.find(params[:id])
        @activity.destory
        json_response "Activity deleted", true, {}, :ok
    end



    private

    def article_params
        params.require(:activity).permit(:ano, :types, :category, :date)
    end

    def set_activity
        @activity = Activity.find(params[:id])
    end


end
