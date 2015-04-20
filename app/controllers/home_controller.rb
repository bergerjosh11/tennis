class HomeController < ApplicationController
  before_filter do
    @home_controller = "current_page_item"
  end

  def index
    if !current_user
      render "not_logged"
    else
      @profile = current_user.profile
      get_last_matches!
      if @profile.nick == nil
        flash[:error] = "First complete profile"
        redirect_to profile_path
      else
        render "index", :layout => "logged"
      end
    end
  end
end
