# frozen_string_literal: true

class PokerSlackMessage
  attr_reader :story_name, :poker_session, :slack_url
  MAX_ACTIONS_PER_ATTACHMENT = 5

  def initialize(story_name, poker_session, slack_url)
    @story_name = story_name
    @poker_session = poker_session
    @slack_url = slack_url
  end

  Attachment = Struct.new(:name, :text, :type, :value)

  def attachments
    text = 'Please pick an estimate'
    arr = []
    actions.each_slice(MAX_ACTIONS_PER_ATTACHMENT).with_index do |action_group, i|
      attachment = {
        fallback: 'You are unable to make an estimate',
        callback_id: poker_session.id,
        color: '#3AA3E3',
        attachment_type: 'default'
      }
      attachment[:actions] = action_group

      attachment[:text] = text if i == 0

      arr << attachment
    end
    arr
  end

  def actions
    poker_session.scores.map do |score|
      { name: 'estimate', text: score.to_s, type: 'button', value: score.to_f }
    end + default_actions
  end

  def default_actions
    [{
      name: 'skip',
      text: '?',
      type: 'button',
      value: '?'
    },
     {
       name: 'end',
       text: 'End',
       type: 'button',
       style: 'primary',
       value: 'end',
       confirm: {
         title: 'Are you sure?',
         text: 'This will end the poker session and total results!',
         ok_text: 'Yes',
         dismiss_text: 'No'
       }
     }]
  end

  def request
    {
      text: story_name,
      response_type: 'in_channel',
      attachments: attachments
    }
  end

  def send
    RestClient.post(slack_url, request.to_json)
  end
end
