require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  it 'can do anything with super admin' do
    expect(subject.can?(:do, :some_ridiculous_and_not_explicit_action)).to be false
    subject.super_admin = true
    subject.toggle_admin
    expect(subject.can?(:do, :some_ridiculous_and_not_explicit_action)).to be true
  end
end
