class ApplicationController < ActionController::API
    include Response
    include Authenticate
    include JsonapiErrorsHandler
    include Pundit
    #protect_from_forgery

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private

    def user_not_authorized
        flash[:alert] = "You are not authorized to perform this action."
        redirect_to(request.referrer || root_path)
    end

    

    
    ErrorMapper.map_errors!({
        'ActiveRecord::RecordNotFound' => 'JsonapiErrorsHandler::Errors::NotFound'
    })
    rescue_from ::StandardError, with: lambda { |e| handle_error(e) }
    

end
