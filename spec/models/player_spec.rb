require 'rails_helper'

RSpec.describe Player, type: :model do
  it { should validate_presence_of(:password_confirmation).on(:create) }

  context "birth date" do
    it "should be earlier than registration date" do
      player = Player.new(date_of_birth: DateTime.now + 1)
      expect(player).to_not be_valid
    end
  end
end
