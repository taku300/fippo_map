require 'rails_helper'

RSpec.describe Fish, type: :model do
  let(:fish) { build(:fish) }

  describe '釣果新規登録' do
    context '釣果登録がうまくいくとき' do
      it '内容に問題ない場合' do
        expect(fish).to be_valid
        expect(fish.errors).to be_empty
      end
      it 'bodyが255文字以下のユーザーが作成可能' do
        fish.body = 'a' * 255
        expect(fish).to be_valid
        expect(fish.errors).to be_empty
      end
      it 'latitudeが-90~90で入力可能' do
        fish.latitude = 90
        expect(fish).to be_valid
        expect(fish.errors).to be_empty
        fish.latitude = -90
        expect(fish).to be_valid
        expect(fish.errors).to be_empty
        fish.latitude = 0
        expect(fish).to be_valid
        expect(fish.errors).to be_empty
        fish.latitude = 89.99999999
        expect(fish).to be_valid
        expect(fish.errors).to be_empty
      end
      it 'longitude-90~90で入力可能' do
        fish.longitude = 180
        expect(fish).to be_valid
        expect(fish.errors).to be_empty
        fish.longitude = -180
        expect(fish).to be_valid
        expect(fish.errors).to be_empty
        fish.longitude = 0
        expect(fish).to be_valid
        expect(fish.errors).to be_empty
        fish.longitude = 89.99999999
        expect(fish).to be_valid
        expect(fish.errors).to be_empty
      end
      it 'sizeが未入力のとき' do
        fish.size = ''
        expect(fish).to be_valid
        expect(fish.errors).to be_empty
      end
    end
    context '新規登録がうまくいかないとき' do
      it 'fishing_dateが空だと登録できない' do
        fish.fishing_date = ""
        expect(fish).to be_invalid
        expect(fish.errors[:fishing_date]).to include "を入力してください"
      end
      it 'fishing_dateがが日付以外だと登録できない' do
        fish.fishing_date = "date"
        expect(fish).to be_invalid
        expect(fish.errors[:fishing_date]).to include "は日付ではありません"
      end
      it 'bodyが空だと登録できない' do
        fish.body = ""
        expect(fish).to be_invalid
        expect(fish.errors[:body]).to eq ["を入力してください"]
      end
      it 'latitudeが空だと登録できない' do
        fish.latitude = ""
        expect(fish).to be_invalid
        expect(fish.errors[:latitude]).to include "を入力してください"
      end
      it 'longitudeが空だと登録できない' do
        fish.longitude = ""
        expect(fish).to be_invalid
        expect(fish.errors[:longitude]).to include "を入力してください"
      end
      it 'longitudeが180以上だと登録できない' do
        fish.longitude = 181
        expect(fish).to be_invalid
        expect(fish.errors[:longitude]).to eq ["は-180~180で入力してください"]
      end
      it 'longitudeが-180以下だと登録できない' do
        fish.longitude = -180.00000001
        expect(fish).to be_invalid
        expect(fish.errors[:longitude]).to eq ["は-180~180で入力してください"]
      end
      it 'longitudeが数字以外だと登録できない' do
        fish.longitude = "a"
        expect(fish).to be_invalid
        expect(fish.errors[:longitude]).to eq ["は-180~180で入力してください"]
      end
      it 'sizeが整数以外だと登録できない' do
        fish.size = "a"
        expect(fish).to be_invalid
        expect(fish.errors[:size]).to eq ["は数値で入力してください"]
      end
      it 'sizeが少数だと登録できない' do
        fish.size = 100.1
        expect(fish).to be_invalid
        expect(fish.errors[:size]).to eq ["は整数で入力してください"]
      end
      it 'wind_speedが整数以外だと登録できない' do
        fish.wind_speed = "a"
        expect(fish).to be_invalid
        expect(fish.errors[:wind_speed]).to eq ["は数値で入力してください"]
      end
      it 'temperatureが整数以外だと登録できない' do
        fish.temperature = "a"
        expect(fish).to be_invalid
        expect(fish.errors[:temperature]).to eq ["は数値で入力してください"]
      end
    end
  end
end
