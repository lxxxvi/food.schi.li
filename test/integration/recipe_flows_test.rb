require 'test_helper'

class RecipeFlowsTest < ActionDispatch::IntegrationTest

  def setup
    login_user(users(:john))
  end

  test 'user visits recipes index page' do
    get recipes_path
    assert_response :success
    assert_select 'h1', 'Recipes'
    assert_select 'a.primary.button', 'New Recipe'
  end

  test 'user visits recipe page' do
    get recipe_path(recipes(:apple_pie))
    assert_response :success
    assert_select 'h1', 'Apple Pie'
    assert_select 'a.secondary.button', 'Edit'
    assert_select 'a.warning.button', 'Delete'
  end

  test 'user adds a recipe' do
    get new_recipe_path
    assert_response :success
    assert_select 'h1', 'New Recipe'
    assert_select "input[type='submit'][value='Create Recipe']"
    assert_select 'a.secondary.button', 'Cancel'

    post '/recipes',
      params: {
        recipe: {
          name: '',
          servings: ''
        }
      }
    assert_response :success
    assert_equal 'Invalid input', flash[:error]

    post '/recipes',
      params: {
        recipe: {
          name: 'Lasagne',
          servings: '4'
        }
      }
    follow_redirect!
    assert_response :success
    assert_equal 'Recipe added', flash[:notice]
  end

  test 'user edits a recipe' do
    recipe = recipes(:apple_pie)
    get edit_recipe_path(recipe)
    assert_response :success
    assert_select 'h1', 'Edit Apple Pie'
    assert_select "input[type='submit'][value='Update Recipe']"
    assert_select 'a.secondary.button', 'Cancel'

    put "/recipes/#{recipe.id}",
      params: {
        recipe: {
          name: 'Apfelkuchen',
          servings: '80'
        }
      }
    follow_redirect!
    assert_response :success
    assert_equal 'Recipe updated', flash[:notice]
  end

  test 'user deletes a recipe' do
    delete recipe_path(recipes(:apple_pie))
    follow_redirect!
    assert_response :success
    assert_select 'h1', 'Recipes'
    assert_equal 'Recipe deleted', flash[:notice]
  end
end
