RSpec.describe Welcome::HomeController do
  describe 'GET #show' do
    it 'renders the home template' do
      get :show
      expect(response).to render_template(:show)
    end
  end
end
