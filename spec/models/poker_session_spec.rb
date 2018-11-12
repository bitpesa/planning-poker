require 'rails_helper'

RSpec.describe PokerSession do
  it { is_expected.to have_many(:estimates) }
  it { is_expected.to have_many(:users).through(:estimates) }

  let(:poker_session) { FactoryBot.create(:poker_session) }

  describe '#closest_story_number_to_average' do
    context 'when a 3 and a 5 are voted for' do
      let!(:estimate3) { FactoryBot.create(:estimate, number: 3, poker_session: poker_session) }
      let!(:estimate5) { FactoryBot.create(:estimate, number: 5, poker_session: poker_session) }

      it 'will return 5' do
        expect(poker_session.closest_story_number_to_average).to eq 5
      end
    end
  end
end
