require 'rails_helper'

RSpec.describe PokerSession do
  it { is_expected.to have_many(:estimates) }
  it { is_expected.to have_many(:users).through(:estimates) }

  let(:poker_session) { FactoryBot.create(:poker_session) }

  describe '#average_estimate' do
    context 'returns the average estimate' do
      let!(:estimate3) { FactoryBot.create(:estimate, number: 3, poker_session: poker_session) }
      let!(:estimate5) { FactoryBot.create(:estimate, number: 5, poker_session: poker_session) }

      it 'will return 4' do
        expect(poker_session.average_estimate).to eq 4
      end
    end

    context 'ignoring skip_votes' do
      let!(:estimate3) { FactoryBot.create(:estimate, number: 3, poker_session: poker_session) }
      let!(:estimate5) { FactoryBot.create(:estimate, number: 5, poker_session: poker_session) }
      let!(:skipped_estimate100) do
        FactoryBot.create(:estimate,
                          :skipped,
                          number: 100,
                          poker_session: poker_session)
      end

      it 'will return 4' do
        expect(poker_session.average_estimate).to eq 4
      end
    end
  end

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
