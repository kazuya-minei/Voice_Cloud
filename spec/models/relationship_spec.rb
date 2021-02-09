require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let! (:user)  { create(:user) }
  let! (:other_user) { create(:user) }

  before do
    @relationship = user.active_relationships.build(followed_id: other_user.id)
    expect(@relationship.valid?).to be_truthy
  end 

  describe "バリデーション" do
    context "follower_id" do
      it "存在性" do
        @relationship.follower_id = nil
        expect(@relationship.invalid?).to be_truthy
      end
    end

    context "followed_id" do
      it "存在性" do
        @relationship.followed_id = nil
        expect(@relationship.invalid?).to be_truthy
      end
    end
  end
end
