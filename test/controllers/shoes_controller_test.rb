require 'test_helper'

class ShoesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get shoes_index_url
    assert_response :success
  end

  test "should get show" do
    get shoes_show_url
    assert_response :success
  end

  test "should get create" do
    get shoes_create_url
    assert_response :success
  end

  test "should get new" do
    get shoes_new_url
    assert_response :success
  end

  test "should get destroy" do
    get shoes_destroy_url
    assert_response :success
  end

  test "should get edit" do
    get shoes_edit_url
    assert_response :success
  end

  test "should get update" do
    get shoes_update_url
    assert_response :success
  end

end
