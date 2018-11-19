class PokerSessionsController < ApplicationController
  def create
    story_name = params[:text]
    timebox = story_name.downcase.include?('timebox')
    if timebox
      poker_session = PokerSession::Timebox.new(story_name: story_name)
    else
      poker_session = PokerSession::Effort.new(story_name: story_name)
    end

    if poker_session.save
      PokerSlackMessage.new(story_name, poker_session).send
      head 200
    else
      head 422
    end
  end
end
