module ControllerMacros
  def login_super_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      user = FactoryGirl.create(:user, :super_admin)
      sign_in user
      user.toggle_admin unless user.admin_enabled?
    end
  end
end
