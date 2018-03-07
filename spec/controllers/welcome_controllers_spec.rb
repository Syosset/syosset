require 'rails_helper'

RSpec.describe Welcome::HomeController, type: :controller do
  describe 'GET #show' do
    it 'renders the home template' do
      get :show
      expect(response).to render_template('show')
    end
  end
end

RSpec.describe Welcome::LandingController, type: :controller do
  describe 'GET #show' do
    it 'renders the landing template' do
      get :show
      expect(response).to render_template('show')
    end
  end
end

RSpec.describe Welcome::AboutController, type: :controller do
  describe 'GET #show' do
    it 'renders the about template' do
      get :show
      expect(response).to render_template('show')
    end
  end
end