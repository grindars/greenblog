class CommentsController < ApplicationController
    load_and_authorize_resource

    def create
        @comment = Comment.new(params[:comment])
        @comment.user = current_user
        @comment.post = Post.find(params[:post_id])
        
        respond_to do |format|
        if @comment.save
            format.html { redirect_to @comment.post, notice: 'Comment was successfully created.' }
        else
            format.html do
                session[:failed_comment] = @comment
                redirect_to :controller => 'posts', :action => 'show', :id => @comment.post, :anchor => "comment_form"
            end
        end
        end
    end

    def update
        @comment = Comment.find(params[:id])

        respond_to do |format|
            if @comment.update_attributes(params[:comment])
                format.html { redirect_to @comment.post, notice: 'Comment was successfully updated.' }
            else
                format.html { render action: "edit" }
            end
        end
    end

    def destroy
        @comment = Comment.find(params[:id])
        post = @comment.post
        @comment.destroy

        respond_to do |format|
            format.html { redirect_to post }
        end
    end
end
