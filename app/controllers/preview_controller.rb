class PreviewController < ApplicationController
    def convert
        @title = params[:title]
        @body = params[:body]
        
        respond_to do |format|
            format.html { render :layout => !request.xhr? }
        end
    end
end
