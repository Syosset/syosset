require 'rails_helper'

RSpec.describe Admin::DepartmentsController, type: :controller do
  login_super_admin

  describe "POST create" do

    context "with valid attributes" do
      it "creates a new department" do
        expect{
          post :create, params: { department: FactoryGirl.attributes_for(:department) }
        }.to change(Department,:count).by(1)
      end

      it "redirects to the new department" do
        post :create, params: { department: FactoryGirl.attributes_for(:department) }
        response.should redirect_to Department.last
      end
    end
  end

  describe "DELETE destroy" do
    before(:each) do
        @department = create(:department)
        @department2 = create(:department)
        delete :destroy, params: { id: @department.id }
    end

    it 'should delete the department' do
        expect(Department.all.to_a).to eq [@department2]
    end
  end
end
