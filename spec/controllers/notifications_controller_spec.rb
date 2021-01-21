require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do
  let!(:client) { create(:client) }
  let!(:admin) { create(:admin) }
  describe 'GET index' do
    let!(:cnotification) { create(:notification, user: client, title: "users notif") }
    let!(:notifications) { create_list(:notification, 4) }
    it 'returns all notifications with seen indication' do
      allow_any_instance_of(NotificationsController).to receive(:current_user).and_return(admin);
      get :index
      response_body = JSON.parse(response.body)
      expect(response_body.size).to eq(5)
      expect(response_body.first["title"]).to eq("users notif")
      expect(response_body.first["seen"]).to eq(false)
    end
    it 'returns all clients notifications' do
      allow_any_instance_of(NotificationsController).to receive(:current_user).and_return(client);
      get :index
      response_body = JSON.parse(response.body)
      expect(response_body.size).to eq(1)
      expect(response_body.first["title"]).to eq(cnotification.title)
    end
  end
  describe 'POST create' do
    it 'creates notification with params' do
      allow_any_instance_of(NotificationsController).to receive(:current_user).and_return(admin);
      post :create, params: {notification: {title: "title", description: "desc", user_id: client.id}}
      expect(response).to have_http_status 201
    end
    it 'does not allow to create notification if user is not admin' do
      allow_any_instance_of(NotificationsController).to receive(:current_user).and_return(client);
      post :create, params: {notification: {title: "title", description: "desc", user_id: client.id}}
      expect(response).to have_http_status 403
    end
    it 'returns error if notification cant be saved' do
      allow_any_instance_of(NotificationsController).to receive(:current_user).and_return(admin);
      post :create, params: {notification: {title: "title", description: "desc", user_id: 14}}
      expect(response).to have_http_status 422
      response_body = JSON.parse(response.body)
      expect(response_body["user"]).not_to be_empty
    end
  end
end