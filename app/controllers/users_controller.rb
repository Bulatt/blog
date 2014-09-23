class UsersController < ApplicationController

before_action :current, only: [:show]
before_action :checks_is_admin, only: [:destroy] 

  def show
    @posts = current_user.posts.paginate(page:params[:page], per_page: 50)
  end

  def destroy
    user = User.find(params[:id])
    if (current_user == user) && (current_user.admin?)
      flash[:error] = "Can not delete own admin account!"
    else
      user.destroy
      flash[:success] = "User deleted"
    end
    redirect_to user_path(current_user)

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
