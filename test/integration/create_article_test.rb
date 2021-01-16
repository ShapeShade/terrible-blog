require 'test_helper'

class CreateArticleTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(username: 'testuser', email: 'test@test.com', password: '1234')
    sign_in_as(@user)
  end

  test 'get new article form and create the article' do
    get new_article_path
    assert_response :success
    assert_difference('Article.count', 1) do
      post articles_path, params: { article: { title: 'testarticle', description: 'test test' } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match('testarticle', response.body)
  end
end
