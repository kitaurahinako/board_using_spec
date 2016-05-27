require 'rails_helper'

describe MyThreadsController do
  #=begin
  describe "full access" do

    let(:user) do
      create(:user)
    end

    before do
      sign_in user
    end

    describe 'GET #index' do

      let(:my_thread) do
        create(:my_thread, user_id: user.id)
      end

      it "gets all threads" do
        my_thread
        get :index
        expect(assigns(:my_threads)).to include(my_thread)
      end
      it "renders template index" do
        get :index
        expect(response).to render_template :index
      end
    end #describe index

    describe 'GET #show' do

      let(:my_thread) do
        create(:my_thread, user_id: user.id)
      end

      it "assigns the requested thread" do
        get :show, id: my_thread
        expect(assigns(:my_thread)).to eq my_thread
      end
      it "renders template show" do
        get :show, id: my_thread
        expect(response).to render_template :show
      end
    end

    describe 'GET #new' do
      it "assigns a new thread to @my_thread" do
        get :new
        expect(assigns(:my_thread)).to be_a_new(MyThread)
      end
      it "renders template new" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe 'POST #create' do

      let (:valid_thread) do
        attributes_for(:my_thread)
      end
      let (:invalid_thread) do
        attributes_for(:my_thread, title: nil)
      end

      context "with valid attributes" do
        it "saves the new thread in db" do
          expect{
             post :create,
             my_thread: valid_thread
           }.to change(MyThread, :count).by(1)
        end
        it "redirects to my_thread#index" do
          post :create,
          my_thread: valid_thread
          expect(response).to redirect_to my_threads_path
        end
      end #context

      context "with invalid attributes" do
        it "doesn't save the new thread" do
          expect{
             post :create,
             my_thread: invalid_thread
           }.not_to change(MyThread, :count)
        end
        it "redirects to thread#index" do
          post :create,
          my_thread: invalid_thread
          expect(response).to render_template :new
        end
      end #context
    end #create


    describe 'GET #edit' do

      let(:my_thread) do
        create(:my_thread, user_id: user.id)
      end

      it "assigns the requested thread" do
        get :edit, id: my_thread
        expect(assigns(:my_thread)).to eq my_thread
      end
      it "renders template edit" do
        get :edit, id: my_thread
        expect(response).to render_template :edit
      end
    end

    describe 'PATCH #update' do

      let(:my_thread) do
        create(:my_thread, user_id: user.id)
      end

      it "locates the requested thread" do
        patch :update, id: my_thread,
        my_thread: attributes_for(:my_thread)
        expect(assigns(:my_thread)).to eq(my_thread)
      end
      it "changes thread's attributes" do
        patch :update, id: my_thread,
        my_thread: attributes_for(:my_thread, title: 'title2')
        my_thread.reload
        expect(my_thread.title).to eq('title2')
      end
    end

    describe 'DELETE #destroy' do

      let(:my_thread) do
        create(:my_thread, user_id: user.id)
      end

      it "deletes the thread from the database" do
        my_thread
        expect{
          delete :destroy, id: my_thread
        }.to change(MyThread, :count).by(-1)
      end
      it "redirects to my_threads#index" do
        delete :destroy, id: my_thread
        expect(response).to redirect_to my_threads_path
      end
    end
  end #full access


  describe "guest access" do

    describe 'GET #index' do
      it "requires login" do
        get :index
        expect(response).to redirect_to user_session_path
      end
    end

    describe 'GET #show' do
      let(:my_thread) do
        create(:my_thread)
      end
      it "requires login" do
        get :show, id: my_thread
        expect(response).to redirect_to user_session_path
      end
    end

    describe 'GET #new' do
      it "requires login" do
        get :new
        expect(response).to redirect_to user_session_path
      end
    end

    describe 'GET #edit' do
      let(:my_thread) do
        create(:my_thread)
      end
      it "requires login" do
        get :edit, id: my_thread
        expect(response).to redirect_to user_session_path
      end
    end

    describe 'POST #create' do
      it "requires login" do
        post :create,
        my_thread: attributes_for(:my_thread)
        expect(response).to redirect_to user_session_path
      end
    end

    describe "PATCH #update" do
      let(:my_thread) do
        create(:my_thread)
      end
      it "requires login" do
        put :update, id: my_thread
        expect(response).to redirect_to user_session_path
      end
    end

    describe "DELETE #destroy" do
      let(:my_thread) do
        create(:my_thread)
      end
      it "requires login" do
        delete :destroy, id: my_thread
        expect(response).to redirect_to user_session_path
      end
    end
  end #guest access
end
