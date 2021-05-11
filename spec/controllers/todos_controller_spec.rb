require 'rails_helper'
RSpec.describe TodosController, type: :controller do
  let(:user) { create :user }
  let(:user1) { create :user }
  let(:todo) { create :todo, user: user }
  let(:todo1) { create :todo, user: user }
  let(:todo2) { create :todo, user: user1 }
  let(:valid_params) { { 'todo' => { 'name' => 'Test Todo', 'categories' => %w[home work], 'date' => '2021-05-20', 'is_done' => '0', 'reminder' => '0' } } }

  describe 'When user is not logged in' do
    it 'GET#index - Should be not be able to see todos and redirected to sign in' do
      get :index
      expect(response).to redirect_to('/users/sign_in')
    end

    it 'GET#show - should redirect to users sign in if user is not signed in' do
      get :show, { id: todo.to_param, template: 'todos/show' }
      expect(response).to redirect_to('/users/sign_in')
    end

    it 'GET#new should redirect to sign in when user tries to hit url for new' do
      get :new
      expect(response).to redirect_to('/users/sign_in')
    end

    it 'POST#create - should not create post when user is not signed in' do
      post :create, valid_params
      expect(response).to redirect_to('/users/sign_in')
    end

    it 'GET#edit - should redirect to sign in when user tries to hit url for edit' do
      get :edit, { id: todo.to_param }
      expect(response).to redirect_to('/users/sign_in')
    end

    it 'POST#update - should redirect to sign in when user tries to hit url for update' do
      put :update, { id: todo.to_param, params: valid_params }
      expect(response).to redirect_to('/users/sign_in')
    end

    it 'Delete - should redirect to sign in when user tries to hit url for delete' do
      delete :destroy, { id: todo.to_param, params: valid_params }
      expect(response).to redirect_to('/users/sign_in')
    end
  end

  describe 'When user logged in and having current user' do
    before do
      sign_in user
      controller.stub(:current_user) { user }
    end

    it 'GET#index - user Should be able see todos for the current user only' do
      get :index
      expect(assigns(:todos)).to match_array([todo, todo1])
      expect(response.response_code).to eq 200
    end

    it 'GET#show - should display the todo item details' do
      get :show, { id: todo1.to_param, template: 'todos/show' }
      expect(assigns(:todo)).to match(todo1)
      expect(response.response_code).to eq 200
    end

    it 'POST#create - creates a new Post' do
      expect do
        post :create, valid_params
      end.to change(Todo, :count).by(1)
    end

    it 'GET todos#new' do
      get :new
      expect(response).to render_template('todos/new')
      expect(response.response_code).to eq 200
    end

    it 'GET#edit - should get the edit url' do
      get :edit, { id: todo.to_param }
      expect(response.response_code).to eq 200
    end

    it 'POST#update - should redirect to sign in when user tries to hit url for update' do
      put :update, { id: todo.to_param, todo: valid_params }
      expect(assigns[:todo]).to_not be_new_record
      expect(response).to be_redirect
    end

    it 'Delete - should redirect to sign in when user tries to hit url for update' do
      delete :destroy, { id: todo.to_param }
      expect(Todo.find_by(id: todo.to_param)).to be_nil
    end
  end
end
