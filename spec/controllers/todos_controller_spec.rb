require 'rails_helper'
RSpec.describe TodosController, type: :controller do
	let(:user) {create :user }
  	let(:user1) {create :user }
  	let(:todo) {create :todo, user: user }
  	let(:todo1) {create :todo, user: user }
  	let(:todo2) {create :todo, user: user1 }
  describe "GET index" do  	 	
    it " Should be not be able to see todos and redirected to sign in" do
	    get :index
	    expect(response).to redirect_to ("/users/sign_in")
    end

    it "user Should be able see todos for the current user only" do
    	sign_in user
      controller.stub(:current_user){ user }
	    get :index
	    expect(assigns(:todos)).to match_array([todo, todo1])
	    expect(response.response_code).to eq 200
    end
  end

  describe 'GET show' do
	  it 'should redirect to users sign in if user is not signed in' do
	    get :show, { id: todo.to_param, template: 'todos/show' }
	    expect(response).to redirect_to ("/users/sign_in")
	  end

	  it 'should display the todo item details' do
	  	sign_in user
      controller.stub(:current_user){ user }
	    get :show, { id: todo1.to_param, template: 'todos/show' }
	    expect(assigns(:todo)).to match(todo1)
	    expect(response.response_code).to eq 200
	  end
	end
end