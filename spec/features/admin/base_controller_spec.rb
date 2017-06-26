require 'rails_helper'

RSpec.describe Admin::BaseController, type: :controller do
  it "prevents unauthorized access to the panel" do
    visit admin_root_path

    expect(current_path).to eq new_user_session_path

    within 'h2' do
      expect(page).to have_content 'Log in'
    end
  end

  it "allows a user with admin view policy to access the panel" do
    user = FactoryGirl.build(:user, :admin_panel_acess)
    login_as(user, :scope => :user)

    visit admin_root_path
    expect(current_path).to eq admin_root_path
  end
end
