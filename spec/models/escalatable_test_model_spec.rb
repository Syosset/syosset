require 'rails_helper'

RSpec.describe "Escalatable Models", type: :model do

  subject { build(:escalatable_test_model) }
  let(:user) { build(:user) }

  it "is not initially escalated" do
    expect(EscalationRequest.request_for subject).to be nil
  end

  it "allows a user to request escalation" do
    expect(subject.request_escalation(user)).to be true
    expect(EscalationRequest.request_for subject).to be_truthy
  end

  it "does not allow duplicate escalation requests" do
    expect(subject.request_escalation(user)).to be true
    expect(subject.request_escalation(user)).to be false
    expect(EscalationRequest.where(escalatable: subject).count).to eq 1
  end
end
