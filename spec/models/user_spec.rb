require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'on creation' do

    before do
      User.create(email: 'test@test.com', password: '1234', full_name: 'test')
    end
    it 'generates a authentication token' do
      expect(User.last.authentication_token).not_to be_nil
    end
  end
end
