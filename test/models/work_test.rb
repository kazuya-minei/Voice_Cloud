require "test_helper"

class WorkTest < ActiveSupport::TestCase

  def setup
    @user = users(:minei)
    @work = Work.new(title: "koreha", content: "worknotestdesu", user_id:@user.id)
  end

  test "should be valid" do
    assert @work.valid?
  end

  test "title should be present" do
    @work.title = "   "
    assert_not @work.valid?
  end

  test "content should be present" do
    @work.content = "   "
    assert_not @work.valid?
  end

  test "title should not be too long" do
    @work.title = "a" * 21
    assert_not @work.valid?
  end

  test "content should not be too long" do
    @work.content = "a" * 2001
    assert_not @work.valid?
  end

  test "Is the alignment correct?" do
    assert_equal works(:ad), Work.first
  end


end
