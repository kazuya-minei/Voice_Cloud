require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  let(:invalid?) {user.invalid?}

  describe "バリデーション" do

    context "nameについて" do
      it "存在性" do
        user.name = "     "
        expect(invalid?).to be_truthy
      end
      it "長さ" do
        user.name = "a" * 51
        expect(invalid?).to be_truthy
      end
    end

    context "emailについて" do
      it "存在性" do
        user.email = "     "
        expect(invalid?).to be_truthy
      end
      it "長さ" do
        user.email = "a" * 244+ "@example.com"
        expect(invalid?).to be_truthy
      end
    end

    context "introduction_textについて" do
      it "長さ" do
        user.introduction_text = "a" * 151
        expect(invalid?).to be_truthy
      end
    end

    context "passwordについて" do
      it "存在性" do
        user.password = user.password_confirmation = "     "
        expect(invalid?).to be_truthy
      end
      it "最小文字数" do
        user.password = user.password_confirmation = "a" * 5
        expect(invalid?).to be_truthy
      end
    end

    # context "dependent: :destroy" do
    #   it "userを削除すると紐付いたworkも一緒に削除される" do
    #     user = FactoryBot.create(:user)
    #     user.works << FactoryBot.create(:work)
    #     expect{ user.destroy }.to change{ Work.count }.by(-1)
    #   end
    # end

  end
end
