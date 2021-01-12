require 'test_helper'

# categories test class
class CategoriesTest < ActiveSupport::TestCase
  setup do
    @category = Category.new(name: 'Sports')
  end

  test "categories should be valid" do
    assert(@category.valid?)
  end

  test "name should be present" do
    @category.name = ' '
    assert_not(@category.valid?)
  end

  test "name should be unique" do
    @category.save
    @category2 = Category.new(name: 'Sports')
    assert_not(@category2.valid?)
  end

  test "name should not be too long" do
    @category.name = 'a' * 55
    assert_not(@category.valid?)
  end

  test "name should not be too short" do
    @category.name = 'a'
    assert_not(@category.valid?)
  end
end
