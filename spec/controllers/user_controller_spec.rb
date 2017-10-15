require 'rails_helper'

RSpec.describe UserController, type: :controller do

  describe '#create' do

    let(:params) { {params: {email: "test@test.com", full_name: "test", password: "1234" } } } 
    describe 'with valid attributes' do
      it 'user created and get messages' do
        post :create, params 
        expect(response.status).to eq(200)
        expect(response.body).to include("User created")
      end

      it 'creates a row at the database' do
        expect(User.count).to eq(0)
        post :create, params 
        expect(User.count).to eq(1)
      end
    end

    describe 'with empty attributes' do
      let(:params) { {params: {email: nil, full_name: nil, password: nil } } } 

      it 'user did not created and get status and error messages' do
        post :create, params 
        expect(response.status).to eq(422)
        expect(response.body).to include("Full name should not be empty")
        expect(response.body).to include("Email should not be empty")
        expect(response.body).to include("Password should not be empty")
      end
    end

    describe 'with existing email' do
      before do
        User.create(params[:params])
      end

      it 'user did not created and get status and error messages' do
        post :create, params 
        expect(response.status).to eq(422)
        expect(response.body).to include("Email is already taken")
      end
    end
  end
end
