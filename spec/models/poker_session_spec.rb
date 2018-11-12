require 'rails_helper'

RSpec.describe PokerSession do
  it { is_expected.to have_many(:estimates) }
  it { is_expected.to have_many(:users).through(:estimates) }
end
