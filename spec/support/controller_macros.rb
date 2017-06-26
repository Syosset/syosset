module ControllerMacros
  def login_super_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in FactoryGirl.create(:user, :super_admin)
    end
  end
end
