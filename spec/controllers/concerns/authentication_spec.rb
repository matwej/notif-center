require 'rails_helper'

RSpec.describe Authentication, type: :concern do
  let!(:user) { create(:client) }
  context '#token' do
    it 'returns token for provided credentials' do
      allow(JsonWebToken).to receive(:encode).and_return('token');
      authentication = Authentication.new(user.email, user.password);
      expect(authentication.token).to eq('token');
    end

    it 'sets error on invalid credentials' do
      authentication = Authentication.new(user.email, "wrong");
      authentication.token
      expect(authentication.errors[:user]).not_to be_empty;
    end
  end
end