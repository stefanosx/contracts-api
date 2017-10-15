require 'rails_helper'

RSpec.describe ContractController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe '#create without user' do
    it 'raise unauthorizes request' do
      post :create
      expect(response.status).to eq(401)
    end
  end

  describe "#create" do
    before do
      @user = User.create(user_params) 
      @request.headers['X-User-Email'] = @user.email
      @request.headers['X-User-Token'] = @user.authentication_token
    end
      
    let(:params) { {params: {vendor: "test", starts_on: "10-10-2017", ends_on: "10-11-2017"} } }
    let(:user_params) { {email: "test@test.com", full_name: "test", password: "1234" } } 

    describe 'with valid attributes' do
      it 'contact created successfully' do
        post :create, params 
        expect(response.status).to eq(200)
        expect(response.body).to include("Contract created")
      end

      it 'creates a row at the database' do
        expect(Contract.count).to eq(0)
        post :create, params 
        expect(Contract.count).to eq(1)
      end
    end

    describe 'with not valid attributes' do
      let(:params) { {params: {vendor: nil, starts_on: nil, ends_on: nil} } }

      it 'contract is not created and display correct error messages' do
        post :create, params 
        expect(response.status).to eq(422)
        expect(response.body).to include("Vendor should not be empty")
        expect(response.body).to include("Starts on should not be empty")
        expect(response.body).to include("Ends on should not be empty")
      end
  
      describe 'when ends_on < starts_on' do
        let(:params) { {params: {vendor: "test", starts_on: "10-12-2017", ends_on: "10-11-2017"} } }
        it 'contact created successfully' do
          post :create, params 
          expect(response.status).to eq(422)
          expect(response.body).to include("Ends on should be greater than Starts on")
        end
      end
    end
  end
end
