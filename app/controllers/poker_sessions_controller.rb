class PokerSessionsController < ApplicationController
  def create
    poker_session = PokerSession.new
    if poker_session.save
      render json: { session_id: poker_session.id }
    else
      head 422
    end
  end
end
