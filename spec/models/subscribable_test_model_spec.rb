require 'rails_helper'

RSpec.describe "Subscribable Models", type: :model do
  subject { build(:subscribable_test_model) }
  let(:user) { create(:user) }

  it "does not consider a user who hasn't subscribed as a subscriber" do
    expect(subject.subscriber?(user)).to be false
  end

  it "can be subscribed to" do
    subject.subscribe_user(user)

    expect(subject.subscriber?(user)).to be true
  end

  it "can be unsubscribed from" do
    subject.subscribe_user(user)
    subject.unsubscribe_user(user)
    expect(subject.subscriber?(user)).to be false
    expect(subject.subscription_for(user).active?).to be false
  end

  it "can mass cancel all subscriptions" do
    subject.subscribe_user(user)
    user2 = build(:user)
    subject.subscribe_user(user2)

    subject.unsubscribe_all
    expect(subject.subscriber?(user)).to be false
    expect(subject.subscriber?(user2)).to be false
  end

  it "can alert all subscribers" do
    subject.subscribe_user(user)

    expect(Alert.user(user).first).to be nil
    subject.alert_subscribers
    expect(Alert.user(user).first).to be_truthy
  end

  it "can exclude sending an alert to certain people" do
    subject.subscribe_user(user)
    user2 = create(:user)
    subject.subscribe_user(user2)

    subject.alert_subscribers(except: [user])

    expect(Alert.user(user).first).to be nil
    expect(Alert.user(user2).first).to be_truthy
  end

  it "allows overriding the subscription alert class" do
    subject.subscribe_user(user)
    subject.alert_subscribers
    alert = Alert.user(user).first

    expect(alert.link).to eq "i-love-tests"
    alert.rich_message.each do |element|
      expect(element[:message]).to eq "The tests went well."
    end
  end
end
