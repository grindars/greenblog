class PostsController < ApplicationController
    load_and_authorize_resource
    
    def index
        @posts = Post.visible_to_user(current_user)
                     .order("created_at DESC")
                     .paginate(:page => params[:page])

        respond_to do |format|
            format.html
        end
    end

    def show
        @post = Post.find(params[:id])
        @comments = @post.comments.order("created_at DESC").paginate(:page => params[:page])
        @failed_comment = session[:failed_comment]
        session.delete :failed_comment
                
        respond_to do |format|
            format.html
        end
    end

    def new
        @post = Post.new

        respond_to do |format|
            format.html
        end
    end

    def edit
        @post = Post.find(params[:id])
    end

    def create
        @post = Post.new(params[:post])
        @post.user = current_user

        respond_to do |format|
            if @post.save
                format.html { redirect_to @post, notice: 'Post was successfully created.' }
            else
                format.html { render action: "new" }
            end
        end
    end
    
    def update
        @post = Post.find(params[:id])

        respond_to do |format|
            if @post.update_attributes(params[:post])
                format.html { redirect_to @post, notice: 'Post was successfully updated.' }
            else
                format.html { render action: "edit" }
            end
        end
    end

    def destroy
        @post = Post.find(params[:id])
        @post.destroy

        respond_to do |format|
            format.html { redirect_to posts_url }
        end
    end
    
    def feed
        @posts = Post.visible_to_user(current_user).order("created_at DESC").limit(20)
        @description = "All posts"
        @link = posts_url
        
        respond_to do |format|
            format.rss
        end
    end
    
    def search
        @query = params[:search][:query] || ""
        @posts = Post.visible_to_user(current_user).paginate(:page => params[:page])
        
        respond_to do |format|
            format.html
        end
    end
end
