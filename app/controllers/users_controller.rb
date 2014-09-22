class UsersController < ApplicationController

before_action :current, only: [:show]
before_action :checks_is_admin, only: [:destroy] 

  def show
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to root_path
      flash[:success] = "User deleted"
    end

  end

  private

    def current
      @user = User.find(params[:id])
      if @user == current_user 
        return
      else
        flash[:error] = "Please sign in"
        redirect_to root_path
       end   
    end
end
