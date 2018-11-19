FactoryBot.define do
  factory :poker_session do
    completed { false }
  end

  factory :effort_poker_session, class: 'PokerSession::Effort' do
    completed { false }
  end

  factory :timebox_poker_session, class: 'PokerSession::Timebox' do
    completed { false }
  end
end
