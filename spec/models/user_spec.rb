require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'on creation' do
    describe 'with valid attributes' do
      before do
        User.create(email: 'test@test.com', password: '1234', full_name: 'test')
      end
      it 'generates a authentication token' do
        expect(User.last.authentication_token).not_to be_nil
      end
    end
    describe 'with unvalid attributes' do
      it 'raise validation error' do
        expect{ User.create!(email: 'test')}.to raise_error(ActiveRecord::RecordInvalid)
        expect{ User.create!(full_name: 'test')}.to raise_error(ActiveRecord::RecordInvalid)
        expect{ User.create!(email: 'test', full_name: 'test')}.to raise_error(ActiveRecord::RecordInvalid)
        expect{ User.create!(email: 'test', full_name: 'test', password: nil)}.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
