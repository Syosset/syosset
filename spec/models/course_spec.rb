require 'rails_helper'

RSpec.describe Course, type: :model do
  subject { create(:course) }
  let(:course_collaborators) { subject.collaborator_group }

  let(:department) { subject.department }
  let(:department_collaborators) { department.collaborator_group }

  it 'maintains its own set of collaborators' do
    user = build(:user)
    expect { course_collaborators.add(user) }.to change { subject.send('*collaborators') }.from( [] ).to( [user.id] )
  end

  it 'merges in collaborators from the department it belongs to' do
    user = build(:user)
    expect { department_collaborators.add(user) }.to change { subject.send('*collaborators') }.from([]).to([user.id])
  end
end
