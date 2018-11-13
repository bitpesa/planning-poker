require 'rails_helper'

RSpec.describe Estimate do
  describe '.counted' do
    let!(:estimate) { FactoryBot.create(:estimate) }
    let!(:estimate2) { FactoryBot.create(:estimate) }
    let!(:skipped_estimate) { FactoryBot.create(:estimate, :skipped) }

    it 'returns only estimates that did not skip vote' do
      expect(described_class.counted).to eq [estimate, estimate2]
    end
  end

  describe '#result_string' do
    let(:user) { FactoryBot.create(:user, name: 'jerome') }
    context 'with a normal estimate' do
      let(:estimate) { FactoryBot.create(:estimate, user: user, number: 3) }

      it 'will return a message saying that user voted' do
        expect(estimate.result_string).to eq 'jerome voted 3'
      end
    end

    context 'with a skip_vote estimate' do
      let(:estimate) { FactoryBot.create(:estimate, :skipped, user: user) }

      it 'will return a message saying that user skipped voting' do
        expect(estimate.result_string).to eq 'jerome skipped voting'
      end
    end
  end
end
