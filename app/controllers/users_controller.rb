class UsersController < ApplicationController
    load_and_authorize_resource
    
    def index
        @users = User.order("created_at").paginate(:page => params[:page])

        respond_to do |format|
            format.html
        end
    end

    def show
        @user = User.find(params[:id])

        respond_to do |format|
            format.html
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])

        respond_to do |format|
            attributes = params[:user].clone
            attributes.delete :password if attributes[:password].empty?
            attributes.delete :is_admin
            
            @user.attributes = attributes
            unless params[:user][:is_admin].nil?
                @user.is_admin = params[:user][:is_admin]
            end
            
            if @user.save 
                format.html { redirect_to @user, notice: 'User was successfully updated.' }
            else
                format.html { render action: "edit" }
            end
        end
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy

        respond_to do |format|
            format.html { redirect_to users_url }
        end
    end
end

