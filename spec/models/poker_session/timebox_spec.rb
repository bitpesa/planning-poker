require 'rails_helper'
RSpec.describe PokerSession::Timebox do
  subject(:poker_session) { FactoryBot.create(:timebox_poker_session, story_name: 'Testing poker sessions') }
  describe '#scores' do
    its(:scores) do
      is_expected.to eq [
        '0.5 Days',
        '1 Day',
        '1.5 Days',
        '2 Days',
        '2.5 Days',
        '3 Days',
        '3.5 Days',
        '4 Days',
        '4.5 Days',
        '5 Days'
      ]
    end
  end

  describe '#closest_story_number_to_average' do
    context 'when 3.5 Days and a 1 Day are voted for' do
      let!(:estimate3) { FactoryBot.create(:estimate, number: 1, poker_session: poker_session) }
      let!(:estimate5) { FactoryBot.create(:estimate, number: 3.5, poker_session: poker_session) }

      it 'will return 2.0' do
        expect(poker_session.closest_story_number_to_average).to eq 2.0
      end
    end

    context 'when 0.5 Days and a 5 Days are voted for' do
      let!(:estimate3) { FactoryBot.create(:estimate, number: 0.5, poker_session: poker_session) }
      let!(:estimate5) { FactoryBot.create(:estimate, number: 5, poker_session: poker_session) }

      it 'will return 2.0' do
        expect(poker_session.closest_story_number_to_average).to eq 2.5
      end
    end
  end

  describe '#complete_session_text' do
    let(:user1) { FactoryBot.create(:user, name: 'jerome') }
    let(:user2) { FactoryBot.create(:user, name: 'callum') }
    let!(:estimate3) { FactoryBot.create(:estimate, number: 3, poker_session: poker_session, user: user1) }
    let!(:estimate5) { FactoryBot.create(:estimate, number: 5, poker_session: poker_session, user: user2) }

    it 'will return the correct text' do
      poker_session.complete_session
      expect(poker_session.complete_session_text).to eq "*Testing poker sessions*\njerome voted 3 days and callum voted 5 days\n*The average vote was 4 days*"
    end
  end
end

