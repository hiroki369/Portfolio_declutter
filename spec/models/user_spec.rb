require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
	describe 'バリデーションテスト' do
		let(:user){build(:user)}
		subject {test_user.valid?}
		context 'nameカラム' do
			let(:test_user){ user }
			it '空欄でない' do
				test_user.name = ''
				is_expected.to eq false;
			end
			it '2文字以上であること' do
        test_user.name = Faker::Lorem.characters(number:1)
        is_expected.to eq false;
      end
		end
	end
end