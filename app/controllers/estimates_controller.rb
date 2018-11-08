class EstimatesController < ApplicationController
  def create
    payload = JSON.parse(params[:payload])
    payload = ActiveSupport::HashWithIndifferentAccess.new(payload)

    Rails.logger.info payload
    poker_session_id = payload[:callback_id]

    action = payload[:actions].first

    poker_session = PokerSession.find(poker_session_id)
    number = action[:value]
    user = find_or_create_user(payload[:user])
    if action[:name] == 'end'
      poker_session.complete_session
      render json: {
        response_type: 'in_channel',
        replace_original: true,
        text: "*The team voted #{poker_session.result}*"
      }
    else
      estimate = poker_session.estimates.new(
        user: user,
        number: number
      )

      if estimate.save
        render json: {
          response_type: "ephemeral",
          replace_original: false,
          text: "You estimated #{estimate.number}, end the planning session to see the results!"
        }
      else
        render json: {
          response_type: "ephemeral",
          replace_original: false,
          text: "You've already estimated!"
        }
      end
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
