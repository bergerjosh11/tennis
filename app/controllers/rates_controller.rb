class RatesController < ApplicationController
  layout "logged"

  before_filter :authenticate_user!
  before_filter :check_profile!
  before_filter :get_last_matches!

  before_filter do
    @rates_controller = "current_page_item"
  end


  def create
    @match = @profile.matches.find(params[:match_id])

    if @match.is_rated(@profile)
      flash[:error] = "Opponant cannot be assessed"

      redirect_to match_path(@match)
      return
    end

    @rate = @match.rates.new(params[:rate])
    @rate.who_gave = @profile

    if @match.first_player == @profile
      @match.is_rated_by_first_player = true
      @rate.owner = @match.second_player
    else
      @match.is_rated_by_second_player = true
      @rate.owner = @match.first_player
    end

    if @rate.save
      @match.save
    else
      flash[:error] = "Reason assesment can't be empty"
    end

    redirect_to match_path(@match)
  end

end
