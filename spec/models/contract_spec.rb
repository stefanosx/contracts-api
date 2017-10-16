require 'rails_helper'

RSpec.describe Contract, type: :model do
  describe 'with unvalid attributes' do
    let(:params) { {vendor: 'test', starts_on: '12-10-2017', ends_on: '12-09-2017'} }
    it 'raise validation error' do
      expect{ Contract.create!(vendor: 'test') }.to raise_error(ActiveRecord::RecordInvalid)
      expect{ Contract.create!(starts_on: 'test') }.to raise_error(ActiveRecord::RecordInvalid)
      expect{ Contract.create!(vendor: 'test', starts_on: '12-10-2017') }.
        to raise_error(ActiveRecord::RecordInvalid)
      expect{ Contract.create!(vendor: 'test', starts_on: '12-10-2017', ends_on: nil) }.
        to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'raises error when ends_on < starts_on' do
      expect{ Contract.create!(params) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe 'with valid attributes' do
    let(:user) { User.create(email: 'test@test.com', password: '1234', full_name: 'test') }
    let(:params) { {vendor: 'test', starts_on: '12-10-2017',
                    ends_on: '12-12-2017', user_id: user.id} }
    it 'not raise error' do
      expect{ Contract.create!(params) }.not_to raise_error
    end
  end
end
