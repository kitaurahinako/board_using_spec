require 'rails_helper'

describe MyCommentsController do

  let!(:my_thread) do
    create(:my_thread)
  end

  describe "full access" do

    let(:user) do
      create(:user)
    end

    before do
      sign_in user
    end

    describe 'POST #create' do

      context "with valid attributes" do

        let (:comment) do
          attributes_for(:my_comment)
        end

        it "saves the new comment in db" do
          my_comment = attributes_for(:my_comment)
          expect{
            post :create,
            my_thread_id: my_thread.id,
            my_comment: comment
                  }.to change(MyComment, :count).by(1)
        end
        it "redirects to thread#show" do
          post :create,
          my_thread_id: my_thread.id,
          my_comment: attributes_for(:my_comment)
          expect(response).to redirect_to my_thread_path(my_thread.id)
        end
      end #context

      context "with invalid attributes" do
        let (:invalid_comment) do
          attributes_for(:my_comment, content: nil)
        end
        it "doesn't save" do
          expect{
            post :create,
            my_thread_id: my_thread.id,
            my_comment: invalid_comment
          }.not_to change(MyComment, :count)
        end
      end
    end #describe(index)

    describe 'GET #edit' do

      let!(:my_comment) do
        create(:my_comment, user_id: user.id, my_thread_id: my_thread.id)
      end

      it "assigns the requested comment" do
        get :edit, id: my_comment
        expect(assigns(:my_comment)).to eq my_comment
      end
      it "renders template edit" do
        get :edit, id: my_comment
        expect(response).to render_template :edit
      end
    end

    describe 'PATCH #update' do

      let!(:my_comment) do
        create(:my_comment, user_id: user.id, my_thread_id: my_thread.id)
      end

      it "locates the requested comment" do
        patch :update, id: my_comment,
        my_comment: attributes_for(:my_comment)
        expect(assigns(:my_comment)).to eq(my_comment)
      end
      it "changes comment's attributes" do
        patch :update, id: my_comment,
        my_comment: attributes_for(:my_comment, content: "おはよう")
        my_comment.reload
        expect(my_comment.content).to eq("おはよう")
      end
    end

    describe 'DELETE #destroy' do

      let!(:my_comment) do
        create(:my_comment, user_id: user.id, my_thread_id: my_thread.id)
      end

      it "deletes the comment from the db" do
        my_comment
        expect{
          delete :destroy, id: my_comment
        }.to change(MyComment, :count).by(-1)
      end
      it "redirects to threads#show"do
        delete :destroy, id:my_comment
        expect(response).to redirect_to my_thread_path(my_comment.my_thread_id)
      end
    end #delete
  end #full access


  describe "guest access" do

    describe 'POST #create' do
      it "requires login" do
        post :create,
        my_thread_id: my_thread.id,
        my_comment: attributes_for(:my_comment)
        expect(response).to redirect_to user_session_path
      end
      it "can't create" do
        expect {
          post :create,
          my_thread_id: my_thread.id,
          my_comment: attributes_for(:my_comment)
        }.to_not change(MyComment, :count)
      end
    end

    describe 'GET #edit' do
      let!(:my_comment) do
        create(:my_comment, my_thread_id: my_thread.id)
      end
      it "requires login" do
        get :edit, id: my_comment
        expect(response).to redirect_to user_session_path
      end
    end

    describe 'PATCH #update' do
      let!(:my_comment) do
        create(:my_comment, my_thread_id: my_thread.id, content: 'こんにちは')
      end
      it "requires login" do
        patch :update, id: my_comment
        expect(response).to redirect_to user_session_path
      end
      it "doesn't update" do
        patch :update, id: my_comment,
        my_comment: attributes_for(:my_comment, content: 'おはよう')
        my_comment.reload
        expect(my_comment.content).to eq("こんにちは")
      end
    end

    describe 'DELETE #destroy' do
      let!(:my_comment) do
        create(:my_comment, my_thread_id: my_thread.id)
      end
      it "doesn't delete" do
        my_comment
        expect{
          delete :destroy, id:my_comment
        }.not_to change(MyThread, :count)
      end
      it "requires login" do
        delete :destroy, id: my_comment
        expect(response).to redirect_to user_session_path
      end
    end
  end #guest access
end
