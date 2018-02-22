module ControllerMacros
  def login_super_admin
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:admin]
      user = FactoryBot.create(:user, :super_admin)
      user.renew_admin unless user.admin_enabled?

      Current.authorization = user.authorizations.first
      Current.user = user
    end
  end
end
