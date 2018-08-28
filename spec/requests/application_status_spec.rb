RSpec.describe 'Application status' do
  # syosseths.com production deployments will fail if the application does not report its status
  it 'returns an OK status' do
    get '/status'
    expect(response.body).to include('ok')
  end
end
