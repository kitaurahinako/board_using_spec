require 'test_helper'

class MyThreadsControllerTest < ActionController::TestCase
  setup do
    @my_thread = my_threads(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:my_threads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create my_thread" do
    assert_difference('MyThread.count') do
      post :create, my_thread: { name: @my_thread.name, overview: @my_thread.overview }
    end

    assert_redirected_to my_thread_path(assigns(:my_thread))
  end

  test "should show my_thread" do
    get :show, id: @my_thread
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @my_thread
    assert_response :success
  end

  test "should update my_thread" do
    patch :update, id: @my_thread, my_thread: { name: @my_thread.name, overview: @my_thread.overview }
    assert_redirected_to my_thread_path(assigns(:my_thread))
  end

  test "should destroy my_thread" do
    assert_difference('MyThread.count', -1) do
      delete :destroy, id: @my_thread
    end

    assert_redirected_to my_threads_path
  end
end
