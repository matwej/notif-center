require 'rails_helper'

RSpec.describe AuthRequest, type: :concern do
  let(:headers_with_token) { {'Authorization' => 'Token token'} }
  let(:headers_without_auth) { {} }
  let!(:user) { create(:client) }
  context '#user' do
    it 'returns a user by decoded token' do
      allow(JsonWebToken).to receive(:decode).and_return({user_id: user.id});
      auth_request = AuthRequest.new(headers_with_token);
      expect(auth_request.user.id).to eq(user.id)
    end

    it 'sets an error on missing header' do
      auth_request = AuthRequest.new(headers_without_auth);
      auth_request.user
      expect(auth_request.errors[:token]).not_to be_empty;
    end
  end
end