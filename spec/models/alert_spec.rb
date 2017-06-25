require 'rails_helper'

RSpec.describe Alert do
  it "is invalid without a user" do
    expect(build(:alert, user: nil)).to be_invalid
  end

  it "is valid with a user" do
    expect(build(:alert)).to be_valid
  end
end
