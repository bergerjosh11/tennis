class PlayersController < ApplicationController
  layout "logged"
  
  before_filter :authenticate_user!
  before_filter :check_profile!
  before_filter :get_last_matches!
  
  before_filter do
    @players_controller = "current_page_item"
  end
  
  def index
    @search = Profile.where("user_id != ?", current_user.id).search(params[:search])
    @players = @search.all(:conditions => ["nick is not null and active = ?", true]).paginate :page => params[:page], :per_page => per_page
  end
  
  def show
    @player = Profile.find(params[:id], :conditions => "nick is not null")
    
    @match_request = @player.other_match_requests.new
  end
end