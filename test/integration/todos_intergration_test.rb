require "test_helper"

class TodosIntegrationTest < ActionDispatch::IntegrationTest
  setup do
    @todo = Todo.create!(todoname: "Test Todo", tododescription: "Test Description")
  end

  test "can fetch list of todos" do
    get "/todos", as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_kind_of Array, json_response
  end

  test "can create a todo" do
    assert_difference "Todo.count", 1 do
      post "/todos", params: { todo: { todoname: "New Todo", tododescription: "New Description" } }, as: :json
    end
    assert_response :created
  end

  test "cannot create a todo without a name" do
    assert_no_difference "Todo.count" do
      post "/todos", params: { todo: { tododescription: "Missing Name" } }, as: :json
    end
    assert_response :unprocessable_entity
  end

  test "cannot create a todo without a description" do
    assert_no_difference "Todo.count" do
      post "/todos", params: { todo: { todoname: "Missing Description" } }, as: :json
    end
    assert_response :unprocessable_entity
  end

  test "can show a todo" do
    get "/todos/#{@todo.id}", as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal @todo.todoname, json_response["todoname"]
  end

  test "can update a todo" do
    patch "/todos/#{@todo.id}", params: { todo: { todoname: "Updated Name" } }, as: :json
    assert_response :success
    @todo.reload
    assert_equal "Updated Name", @todo.todoname
  end

  test "cannot update a todo with invalid data" do
    patch "/todos/#{@todo.id}", params: { todo: { todoname: "" } }, as: :json
    assert_response :unprocessable_entity
  end

  test "can delete a todo" do
    assert_difference "Todo.count", -1 do
      delete "/todos/#{@todo.id}", as: :json
    end
    assert_response :no_content
  end
end
