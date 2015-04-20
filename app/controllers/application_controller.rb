class ApplicationController < ActionController::Base
  protect_from_forgery
    
  def after_sign_in_path_for(resource)
    "/" # <- Path you want to redirect the user to.
  end
  
  def per_page
    20
  end
    
  def check_profile!
    @profile = current_user.profile
    if @profile.nick == nil
      flash[:error] = "Najpierw uzupełnij profil!"   
      redirect_to profile_path
    end
  end
  
  def get_last_matches!
    @last_matches = current_user.profile.matches.active.all :limit => 5
    @last_requests = current_user.profile.match_requests.not_cancelled :limit => 5
  end
end
