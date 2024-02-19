require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe 'GET /sessions/new' do
    it 'should get new' do
      get '/sessions/new'
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /sessions' do
    let(:user) {
      create(:user, name: "taro", email: "test@example.com", password: "password")
    }
    it 'should create session' do
      post '/sessions',
      params: {
        session: {
          email: user.email,
          password: user.password
          }
        }
      expect(response).to redirect_to(tasks_path)
      expect(session[:user_id]).to eq user.id
    end

  end

  describe 'DELETE /sessions' do
    let(:user) {
      create(:user, name: "taro", email: "test@example.com", password: "password")
    }

    before do
      sign_in(user)
    end

    it 'should delete session' do
      expect(session[:user_id]).to eq user.id
      delete "/sessions/#{user.id}"
      expect(response).to redirect_to(new_session_path)
      expect(session[:user_id]).to be_nil
    end

  end


end
