require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe 'GET /users/new' do
    context 'ログインしていない場合' do
      it 'should get new' do
        get '/users/new'
        expect(response).to have_http_status(200)
      end
    end

    context 'ログインしている場合' do
      before do
        user = create(:user, name: "taro", email: "test@example.com", password: "password")
        sign_in(user)
      end

      it 'should render users/new' do
        get '/users/new'
        expect(response).to render_template("users/new")
      end
    end

  end

end
