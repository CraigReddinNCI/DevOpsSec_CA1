require "test_helper"

class TodosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @todo = todos(:one)
  end

  test "should get index" do
    get todos_url, as: :json
    assert_response :success
  end

  test "should create todo" do
    assert_difference("Todo.count") do
      post todos_url, params: { todo: { tododescription: @todo.tododescription, todoname: @todo.todoname } }, as: :json
    end
    assert_response :created
  end

  test "should show todo" do
    get todo_url(@todo), as: :json
    assert_response :success
  end

  test "should update todo" do
    patch todo_url(@todo), params: { todo: { tododescription: @todo.tododescription, todoname: @todo.todoname } }, as: :json
    assert_response :success
  end

  test "should destroy todo" do
    assert_difference("Todo.count", -1) do
      delete todo_url(@todo), as: :json
    end
    assert_response :no_content
  end

  test "should not create todo, no name" do
    assert_no_difference("Todo.count") do
      post todos_url, params: { todo: { tododescription: "Sample description" } }, as: :json
    end
    assert_response :unprocessable_entity
  end  

  test "should not create todo, no description" do
    assert_no_difference("Todo.count") do
      post todos_url, params: { todo: { todoname: "Sample Todo" } }, as: :json
    end
    assert_response :unprocessable_entity
  end  

  test "should not update todo, no name" do
    patch todo_url(@todo), params: { todo: { todoname: "" } }, as: :json
    assert_response :unprocessable_entity
  end

  test "should not update todo, no description" do
    patch todo_url(@todo), params: { todo: { tododescription: "" } }, as: :json
    assert_response :unprocessable_entity
  end
end
