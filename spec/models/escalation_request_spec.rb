require 'rails_helper'

RSpec.describe EscalationRequest do
  subject { build(:escalation_request) }
  let(:reviewer) { build(:user) }

  it "is initially pending" do
    expect(subject.pending?).to be true
  end

  it "can be approved" do
    subject.approve!(reviewer)
    expect(subject.approved?).to be true
    expect(subject.reviewer).to eq reviewer
  end

  it "alerts the requester that their request has been approved if approved" do
    expect(EscalationRequest::Alert::Accepted.user(subject.requester).first).to be nil
    subject.approve!(reviewer)
    expect(EscalationRequest::Alert::Accepted.user(subject.requester).first).to be_truthy
  end

  it "can be denied" do
    subject.deny!(reviewer)
    expect(subject.denied?).to be true
    expect(subject.reviewer).to eq reviewer
  end

  it "alerts the requester that their request has been denied if denied" do
    expect(EscalationRequest::Alert::Denied.user(subject.requester).first).to be nil
    subject.deny!(reviewer)
    expect(EscalationRequest::Alert::Denied.user(subject.requester).first).to be_truthy
  end

end
