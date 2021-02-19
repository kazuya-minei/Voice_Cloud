require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @user = create(:user)
    @work = create(:work, user: @user)
    @voice = create(:voice, user: @user, work: @work)
    @comment = create(:comment, user: @user, voice: @voice)
  end

  it 'コメントは140字以内' do
    expect(@comment.valid?).to be_truthy
    @comment.comment = "a" * 141
    expect(@comment.invalid?).to be_truthy
  end

  it 'userが削除されたら紐付いてるvoiceも削除される' do
    expect { @user.destroy }.to change(Comment, :count).by(-1)
  end

  it 'workが削除されたら紐付いてるvoiceも削除される' do
    expect { @voice.destroy }.to change(Comment, :count).by(-1)
  end
end
