class MessagesController < ApplicationController
  layout "logged"

  before_filter :authenticate_user!
  before_filter :check_profile!
  before_filter :get_last_matches!

  before_filter do
    @messages_controller = "current_page_item"
  end

  def create
    if (params[:match_request_id])
      @object = @profile.match_requests.find(params[:match_request_id])
      @message = @object.messages.new(params[:message])
      @message.author = @profile

      if @profile == @object.owner
        @message.addressee = @object.second_player
      else
        @message.addressee = @object.owner
      end

      if @message.save
        redirect_to match_request_path(@object)
      else
        render 'new'
      end
    end

    if (params[:match_id])
      @object = @profile.matches.find(params[:match_id])
      @message = @object.messages.new(params[:message])
      @message.author = @profile

      if @profile == @object.first_player
        @message.addressee = @object.second_player
      else
        @message.addressee = @object.first_player
      end

      if @message.save
        redirect_to match_path(@object)
      else
        render 'new'
      end
    end
  end

  def new
    if(params[:match_id])
      @object = @profile.matches.find(params[:match_id])
      @message = @object.messages.new
    end

    if(params[:match_request_id])
      @object = @profile.match_requests.find(params[:match_request_id])
      @message = @object.messages.new
    end
  end
end
