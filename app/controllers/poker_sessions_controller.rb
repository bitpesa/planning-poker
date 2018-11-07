class PokerSessionsController < ApplicationController
  def create
    story_name = params[:text]
    poker_session = PokerSession.new
    if poker_session.save
      PokerSlackMessage.new(story_name, poker_session.id).send
      head 200
    else
      head 422
    end
  end
end
