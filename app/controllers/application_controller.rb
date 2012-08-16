class ApplicationController < ActionController::Base
    protect_from_forgery
    
    helper_method :recent_posts
  
    def recent_posts
        Post.visible_to_user(current_user)
            .order("created_at DESC")
            .limit(5)
    end
    
    protected
    
    rescue_from Exception, :with => :handle_generic_error
    
    rescue_from ActionController::RoutingError,
              ActiveRecord::RecordNotFound,
              AbstractController::ActionNotFound,
              ActionView::MissingTemplate, :with => :handle_not_found    
    
    rescue_from CanCan::AccessDenied, :with => :handle_access_denied
    
    def handle_generic_error(exception)        
        render_error 500, exception
    end
    
    def handle_not_found(exception)
        Rails.logger.error "Handling 404"
        
        render_error 404, exception
        
        Rails.logger.error "Done."
    end
    
    def handle_access_denied(exception)
        render_error 403, exception
    end    
    
    def render_error(code, exception)
        if Rails.env.production?
            @code, @error = code, exception
            respond_to do |format|
                format.html {
                    render :template => "errors/generic", :layout => 'error', :status => code
                }
            end
        else            
            raise exception
        end
    end
    
end
