require 'Server'

describe Server do
  describe "Test GET endpoint" do
    it 'returns void' do
      get '/balance'

      json = JSON.parse(response.body)
      expect(response).to be_success
    end
  end

  describe "Test POST endpoint" do
    it "posts once" do
      post '/add_balance?address=0x5f862a4adfc4ef14e6c6ee1acaf4838e2a0d34ad'
      json = JSON.parse(response.body)
      expect(response).to be_success
    end

  end
end
