class EstimatesController < ApplicationController
  def create
    #user_name = params[:user_name]
    payload = JSON.parse(params[:payload])
    payload = ActiveSupport::HashWithIndifferentAccess.new(payload)
    Rails.logger.info payload
    slack_id = payload[:slack_id]
    poker_session_id = payload[:callback_id]
    poker_session = PokerSession.find(poker_session_id)
    number = payload[:value]
    user = User.first_or_create_by(slack_id: slack_id)
    estimate = poker_session.estimates.new(
      user: user,
      number: number
    )

    if estimate.save
      head 200
    else
      head 422
    end
  end
end
