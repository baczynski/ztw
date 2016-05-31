require 'rails_helper'

RSpec.describe Tournament, type: :model do
  it "should respond to its fields" do
    tourn = Tournament.new
    expect(tourn).to respond_to(:name)
    expect(tourn).to respond_to(:description)
    expect(tourn).to respond_to(:start_date)
    expect(tourn).to respond_to(:tournament_type)
    expect(tourn).to respond_to(:rounds)
    expect(tourn).to respond_to(:round)
  end

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:start_date) }
  it { should validate_presence_of(:tournament_type) }
  it { should validate_presence_of(:rounds) }

  it { should validate_numericality_of(:rounds).only_integer.is_greater_than(0) }

  context "start date" do
    it "should be later than creation date" do
      tourn = Tournament.new(start_date: DateTime.now - 1)
      expect(tourn).to_not be_valid
    end
  end

  it { should validate_inclusion_of(:tournament_type).in_array Tournament::TOURNAMENT_TYPE.keys }
end
