class ProfilesController < ApplicationController
  layout "logged"

  before_filter :authenticate_user!
  before_filter :check_profile!, :except => [:show, :update]
  before_filter :get_last_matches!

  before_filter do
    @profiles_controller = "current_page_item"
  end

  def show
    @profile = current_user.profile

  end

  def update
    @profile = current_user.profile

    if params[:profile][:nick]
      if params[:profile][:nick].downcase == "account deactivated".downcase
        @profile.errors.add_to_base "Nickname is already in use"
        @profile.nick = params[:profile][:nick]
        render 'show'

        return
      end
    end

    if @profile.update_attributes(params[:profile])
      redirect_to profile_path
    else
      render "show"
    end
  end
end
