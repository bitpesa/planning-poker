class PokerSlackMessage
  attr_reader :story_name, :poker_session_id

  def initialize(story_name, poker_session_id)
    @story_name = story_name
    @poker_session_id = poker_session_id
  end

  def request
    {
      text: story_name,
      attachments: [
        {
          text: 'Please pick an estimate',
          fallback: 'You are unable to make an estimate',
          callback_id: poker_session_id,
          color: '#3AA3E3',
          attachment_type: 'default',
          actions: [
            {
              name: 'estimate',
              text: '1',
              type: 'button',
              value: 1
            },
            {
              name: 'estimate',
              text: '2',
              type: 'button',
              value: 2
            },
            {
              name: 'estimate',
              text: '3',
              type: 'button',
              value: 3
            },                {
              name: 'estimate',
              text: '5',
              type: 'button',
              value: 5
            },                {
              name: 'estimate',
              text: '8',
              type: 'button',
              value: 8
            }
          ]
        },
        {
          fallback: 'You are unable to make an estimate',
          callback_id: poker_session_id,
          color: '#3AA3E3',
          attachment_type: 'default',
          actions: [
            {
              name: 'estimate',
              text: '13',
              type: 'button',
              value: 13
            },
            {
              name: 'estimate',
              text: '20',
              type: 'button',
              value: 20
            },
            {
              name: 'estimate',
              text: '40',
              type: 'button',
              value: 40
            },                {
              name: 'estimate',
              text: '100',
              type: 'button',
              value: 100
            },                {
              name: 'estimate',
              text: '?',
              type: 'button',
              value: '?'
            }
          ]
        },

      ]
    }
  end

  def send
    RestClient.post(slack_url, request.to_json)
  end

  def slack_url
    ENV['SLACK_HOOK_URL']
  end
end
