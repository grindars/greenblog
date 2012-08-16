class ErrorsController < ApplicationController
    def not_found
        raise ActionController::RoutingError, "No route matches [#{request.method.upcase}] #{request.path}"
    end
end
