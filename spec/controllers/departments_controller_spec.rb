require 'rails_helper'

RSpec.describe DepartmentsController do
  describe 'GET index' do
    it 'populates an array of departments' do
      department = create(:department)
      get :index
      expect(assigns(:departments)).to eq([department])
    end
    it 'renders the :index view' do
      get :index
      expect(response).to render_template :index
    end
  end
  describe 'GET #show' do
    it 'assigns the requested department to @department' do
      department = create(:department)
      get :show, params: {id: department}
      expect(assigns(:department)).to eq(department)
    end

    it 'renders the #show view' do
      department = create(:department)
      get :show, params: {id: department}
      expect(response).to render_template :show
    end
  end
end
