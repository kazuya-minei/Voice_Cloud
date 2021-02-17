require 'rails_helper'

RSpec.describe Voice, type: :model do
  before do
    @user = create(:user)
    @work = create(:work, user: @user)
    @voice = create(:voice, user: @user, work: @work)
  end

  it 'userが削除されたら紐付いてるvoiceも削除される' do
    expect { @user.destroy }.to change(Voice, :count).by(-1)
  end

  it 'workが削除されたら紐付いてるvoiceも削除される' do
    expect { @work.destroy }.to change(Voice, :count).by(-1)
  end

end