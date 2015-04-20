class MatchRequestsController < ApplicationController
  layout "logged"

  before_filter :authenticate_user!
  before_filter :check_profile!
  before_filter :get_last_matches!


  before_filter do
    @match_requests_controller = "current_page_item"
  end

  def index
    @owner = true
    if params[:type]
      if params[:type] == "received"
        @title = "recieved"
        @match_requests = @profile.other_match_requests.active.paginate :page => params[:page], :per_page => per_page
        @owner = false
      else
        if params[:type] == "sent"
          @title = "sent"
          @match_requests = @profile.owned_match_requests.active.paginate :page => params[:page], :per_page => per_page
        else
          if params[:type] == "accepted"
            @title = "accepted"
            @match_requests = @profile.match_requests.accepted.paginate :page => params[:page], :per_page => per_page
          else
            @title = "rejected"
            @match_requests = @profile.match_requests.denied.paginate :page => params[:page], :per_page => per_page
          end
        end
      end
      #@ignored = @matches.ignored(player)
      #@played = @matches.not_ignored(player).played
      #@not_played = @matches.not_ignored(player).not_played
    else
      @title = "recieved"
      @match_requests = @profile.other_match_requests.active.paginate :page => params[:page], :per_page => per_page
      @owner = false
    end
  end

  def show
    @match_request = @profile.match_requests.find(params[:id])
    @owner = @match_request.owner

    if @profile == @match_request.owner
      @is_owner = true
    else
      @is_owner = false
    end

    @message = @match_request.messages.new
    @messages = @match_request.messages.all
  end

  def create
    @player = Profile.find(params[:player_id])
    @match_request = @player.other_match_requests.new(params[:match_request])
    @match_request.owner = @profile

    if @match_request.owner == @match_request.second_player
      flash[:error] = "You cannot play with yourself"

      redirect_to player_path(@player)
      return
    end

    if @match_request.save
      redirect_to match_request_path(@match_request)
    else
      @match_requests_controller = ""
      @players_controller = "current_page_item"
      render "players/show"
    end
  end

  def edit_deny
    @match_request = @profile.other_match_requests.find(params[:id])

    if !@match_request.is_active
      flash[:error] = "You cannot reject this offer"
      redirect_to match_request_path(@match_request)

      return
    end

    render 'edit_deny'
  end

  def deny
    @match_request = @profile.other_match_requests.find(params[:id])

    if !@match_request.is_active
      flash[:error] = "You cannot reject this offer"
      redirect_to match_request_path(@match_request)

      return
    end

    if params[:match_request][:why_denied] == ""
      @match_request.errors.add_to_base 'Reason this cannot be empty'
      render 'edit_deny'

      return
    end

    @match_request.denied = true

    if @match_request.update_attributes(params[:match_request])
      @match_request.save

      redirect_to match_requests_path
    else

      render 'edit_deny'
    end
  end

  def cancel
    @match_request = @profile.owned_match_requests.find(params[:id])

    if @match_request.accepted or @match_request.denied or @match_request.cancelled
      flash[:error] = "You cannot cancel this offer"
      redirect_to match_request_path(@match_request)

      return
    end

    @match_request.cancelled = true
    @match_request.save

    redirect_to match_requests_path
  end

end
