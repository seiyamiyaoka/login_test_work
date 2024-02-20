require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  describe "GET /index" do
    context "ログインしていない場合" do
      it "should redirect to new_session_path" do
        get tasks_path
        expect(response).to redirect_to(new_session_path)
      end
    end

    context "ログインしている場合" do
      before do
        user = create(:user, name: "taro", email: "test@example.com", password: "password")
        sign_in(user)
      end

      it "should get index, indexのtemplateがが表示される" do
        get tasks_path
        expect(response).to render_template(:index)
      end
    end

  end

  describe "GET /new" do
    context "ログインしていない場合" do
      it "new_session_pathにリダイレクトする" do
        get new_task_path
        expect(response).to redirect_to(new_session_path)
      end
    end

    context "ログインしている場合" do
      before do
        user = create(:user, name: "taro", email: "test@example.com", password: "password")
        sign_in(user)
      end

      it "should get new, newのtemplateがが表示される" do
        get new_task_path
        expect(response).to render_template(:new)
      end
    end
  end

  describe "POST /create" do
    context "ログインしていない場合" do
      it "should redirect to new_session_path" do
        post tasks_path
        expect(response).to redirect_to(new_session_path)
      end
    end

    context "ログインしている場合" do
      before do
        user = create(:user,
                      name: "taro",
                      email: "test@example.com",
                      password: "password"
                    )
        sign_in(user)
      end

      it "should create task" do
        count = Task.count
        expect(count).to eq 0

        post tasks_path,
          params: {
            task: {
              title: "title",
              content: "content",
            }
          }

        expect(Task.count).to eq 1

        expect(response).to redirect_to(tasks_path)
      end
    end
  end
end
