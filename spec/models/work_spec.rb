require 'rails_helper'

RSpec.describe Work, type: :model do

  before do
    @user = FactoryBot.create(:user)
    @work = @user.works.create(title:"serifu", content:"bosyuu")
  end
  let(:invalid?){@work.invalid?}

  describe "バリデーション" do

    context "title" do
      it "存在性" do
        @work.title = "   "
        expect(invalid?).to be_truthy
      end
      it "長さ" do
        @work.title = "a" * 21
        expect(invalid?).to be_truthy
      end
    end

    context "content" do
      it "存在性" do
        @work.content = "  "
        expect(invalid?).to be_truthy
      end
      it "存在性" do
        @work.content = "a" * 2001
        expect(invalid?).to be_truthy
      end
    end

    it "user_id" do
      expect(@work.user_id).to eq @user.id
    end

  end
end