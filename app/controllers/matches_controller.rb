class MatchesController < ApplicationController
  layout "logged"

  before_filter do
    @matches_controller = "current_page_item"
  end

  before_filter :authenticate_user!
  before_filter :check_profile!
  before_filter :get_last_matches!

  def index

    if params[:type]
      case params[:type]
      when "not_played" then
        @title = "not played"
        @matches = @profile.matches.active.not_ignored(@profile).not_played.paginate :page => params[:page], :per_page => per_page
      when "played"
        @title = "played"
        @matches = @profile.matches.active.not_ignored(@profile).played.paginate :page => params[:page], :per_page => per_page
      when "ignored"
        @title = "ignored"
        @matches = @profile.matches.active.ignored(@profile).paginate :page => params[:page], :per_page => per_page
      else
        @title = "cancelled"
        @matches = @profile.matches.cancelled.paginate :page => params[:page], :per_page => per_page
      end
    else
      @title = "unmatched"
      @matches = @profile.matches.active.not_ignored(@profile).not_played.paginate :page => params[:page], :per_page => per_page
    end

  end

  def show
    @match = @profile.matches.find(params[:id])
    @rate = @match.rates.new
    @messages = @match.messages.all

    if @match.first_player == @profile
      @is_rated = @match.is_rated_by_first_player
    else
      @is_rated = @match.is_rated_by_second_player
    end

    if @match.cancelled
      render 'show_cancelled'

      return
    end

    if @match.is_ignored(@profile)
      render 'show_ignored'

      return
    end

    if !@match.was_played
      if @match.owner == @profile
        render 'provide_info'
      else
        render 'accept'
      end
    end
  end

  def create
    @match_request = @profile.other_match_requests.find(params[:id])
    @messages = @match_request.messages.all

    if !@match_request.is_active
      flash[:error] = "You cannot accept this offer."

      redirect_to match_request_path(@match_request)
      return
    end

    @owner = @match_request.owner

    @match = @owner.owned_matches.new
    @match.first_player = @owner
    @match.second_player = @profile

    if @match.first_player == @match.second_player
      flash[:error] = "Cannot play against yourself."

      redirect_to match_request_path(@match_request)
      return
    end

    @match.messages = @messages

    if @match.save
      @match_request.accepted = true
      @match_request.match = @match
      @match_request.save
      redirect_to match_path(@match)
    else
      flash[:error] = "Cannot accept this offer"
      redirect_to match_request_path(@match_request)
    end
  end

  def update
    @match = @profile.owned_matches.find(params[:id])

    if @match.is_ignored(@profile) or @match.was_played or @match.info_provided or @match.cancelled
      flash[:error] = "You cannot update the data for this match"
      redirect_to match_path(@match)

      return
    end

    if (params[:match][:where] == "" or params[:match][:when] == "")
      flash[:error] = "The result cannot be empty"
      redirect_to match_path(@match)

      return
    end

    if @match.update_attributes(params[:match])
      @match.info_provided = true
      @match.save
      redirect_to match_path(@match)
    else
      flash[:error] = "You cannot accept this offer"
      redirect_to match_path(@match)
    end
  end

  def edit_accept
    @match = @profile.matches_as_second_player.find(params[:id])

    if @match.is_ignored(@profile) or @match.was_played or !@match.info_provided or @match.cancelled
      flash[:error] = "You cannot accept this match"
      redirect_to match_path(@match)

      return
    end

    render 'edit_accept'
  end

  def edit_deny
    @match = @profile.matches_as_second_player.find(params[:id])

    if @match.is_ignored(@profile) or @match.was_played or !@match.info_provided or @match.cancelled
      flash[:error] = "You cannot accept this match"
      redirect_to match_path(@match)

      return
    end

    render 'edit_deny'
  end

  def accept
    @match = @profile.matches_as_second_player.find(params[:id])

    if @match.is_ignored(@profile) or @match.was_played or !@match.info_provided or @match.cancelled
      flash[:error] = "You cannot accept this match"
      redirect_to match_path(@match)

      return
    end

    @match.second_players_description = params[:match][:second_players_description]
    @match.was_played = true
    @match.save

    redirect_to match_path(@match)
  end

  def deny
    @match = @profile.matches_as_second_player.find(params[:id])

    if @match.is_ignored(@profile) or @match.was_played or !@match.info_provided or @match.cancelled
      flash[:error] = "You cannot accept this match"
      redirect_to match_path(@match)

      return
    end

    if (params[:match][:why_denied] == "")
      @match.errors.add_to_base("No reason given")
      render 'edit_deny'
      return
    end

    @match.info_denied = true
    @match.why_denied = params[:match][:why_denied]
    @match.info_provided = false
    @match.save

    redirect_to match_path(@match)
  end

  def ignore
    @match = @profile.matches.find(params[:id])

    if @match.is_ignored(@profile) or @match.was_played or @match.cancelled
      flash[:error] = "Match has already started"
      redirect_to match_path(@match)

      return
    end

    if @profile == @match.first_player
      @match.first_player_ignores = true
    else
      @match.second_player_ignores = true
    end

    @match.save
    redirect_to match_path(@match)
  end

  def stop_ignoring
    @match = @profile.matches.ignored(@profile).find(params[:id])

    if !@match.is_ignored(@profile) or @match.cancelled
      flash[:error] = "Match has already started"
      redirect_to match_path(@match)

      return
    end


    if @profile == @match.first_player
      @match.first_player_ignores = false
    else
      @match.second_player_ignores = false
    end
    @match.save
    redirect_to match_path(@match)
  end
end
