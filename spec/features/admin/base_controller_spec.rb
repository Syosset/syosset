require 'rails_helper'

RSpec.describe Admin::BaseController, type: :controller do
  it "prevents unauthorized access to the panel" do
    visit admin_root_path

    current_path.should eq new_user_session_path

    within 'h2' do
      page.should have_content 'Log in'
    end
  end
end
