class TagsController < ApplicationController
    load_and_authorize_resource
    
    def index
        @tags = Tag.paginate(:page => params[:page])

        respond_to do |format|
            format.html
        end
    end

    def show
        @tag = Tag.find(params[:id])
        @posts = @tag.posts.visible_to_user(current_user).paginate(:page => params[:page])
        
        respond_to do |format|
            format.html
        end
    end

    def new
        @tag = Tag.new

        respond_to do |format|
            format.html
        end
    end

    def edit
        @tag = Tag.find(params[:id])
        
        respond_to do |format|
            format.html
        end        
    end

    def create
        @tag = Tag.new(params[:tag])

        respond_to do |format|
            if @tag.save
                format.html { redirect_to @tag, notice: 'Tag was successfully created.' }
            else
                format.html { render action: "new" }
            end
        end
    end

    def update
        @tag = Tag.find(params[:id])

        respond_to do |format|
            if @tag.update_attributes(params[:tag])
                format.html { redirect_to @tag, notice: 'Tag was successfully updated.' }
            else
                format.html { render action: "edit" }
            end
        end
    end

    def destroy
        @tag = Tag.find(params[:id])
        @tag.destroy

        respond_to do |format|
            format.html { redirect_to tags_url }
            format.json { head :no_content }
        end
    end
    
    def feed
        @tag = Tag.find(params[:id])
        @posts = @tag.posts.visible_to_user(current_user).order("created_at DESC").limit(20)
        @description = "Posts tagged with #{@tag.name}"
        @link = tag_url(@tag)
        
        respond_to do |format|
            format.rss { render "posts/feed" }
        end
    end    
end
