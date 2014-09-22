class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

    def checks_is_admin
      authenticate_user!

      if current_user.admin
        return
      else
        flash[:notice] = "Access is denied"
        redirect_to root_url
      end
    end

    def after_sign_up_path_for(resource)
      user_path(resource)
    end

    def after_sign_in_path_for(resource)
      user_path(resource)
    end

    def render_404
      render :file => 'public/404.html.haml', status: :not_found, layout: 'application'
    end

end
