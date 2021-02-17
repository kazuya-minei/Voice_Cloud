FactoryBot.define do
  factory :voice do
    association :user
    association :work
    voice_data { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/testvoice.mp3')) }
  end
end
