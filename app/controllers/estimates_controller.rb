class EstimatesController < ApplicationController
  def create
    payload = JSON.parse(params[:payload])
    payload = ActiveSupport::HashWithIndifferentAccess.new(payload)

    Rails.logger.info payload
    poker_session_id = payload[:callback_id]

    poker_session = PokerSession.find(poker_session_id)
    number = payload[:value]
    user = find_or_create_user(payload[:user])
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

  def find_or_create_user(slack_user)
    slack_id = slack_user[:id]
    name = slack_user[:name]
    user = User.find_by(slack_id: slack_id)
    user ||= User.create(slack_id: slack_id, name: name)
    user
  end
end
