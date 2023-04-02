require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  let(:another_user) { build(:user, email: user.email) }
  let(:secret_user) { build(:user, :secret) }

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it '内容に問題ない場合' do
        expect(user).to be_valid
        expect(user.errors).to be_empty
      end
      it 'emailが255文字以下のユーザーが作成可能' do
        user.email = 'a' * 245 + '@sample.jp'
        expect(user).to be_valid
        expect(user.errors).to be_empty
      end
      it 'introductionが未入力のとき' do
        user.introduction = ''
        expect(user).to be_valid
        expect(user.errors).to be_empty
      end
      it 'is_publishedがをfalse(非公開)で登録するとき' do
        expect(secret_user).to be_valid
        expect(secret_user.errors).to be_empty
      end
    end
    context '新規登録がうまくいかないとき' do
      it 'nameが空だと登録できない' do
        user.name = ""
        expect(user).to be_invalid
        expect(user.errors[:name]).to eq ["を入力してください"]
      end
      it 'mailが空だと登録できない' do
        user.name = ""
        expect(user).to be_invalid
        expect(user.errors[:name]).to eq ["を入力してください"]
      end
      it 'passwordが空だと登録できない' do
        user.password = ""
        expect(user).to be_invalid
        expect(user.errors[:password]).to eq ["は8文字以上で入力してください"]
      end
      it 'passwordが確認パスワードと合わないとき' do
        user.password_confirmation = "other_password"
        expect(user).to be_invalid
        expect(user.errors[:password_confirmation]).to eq ["とパスワードの入力が一致しません"]
      end
      it "emailが適切でないフォーマットの時は登録できない" do
        user.email = "example@com"
        expect(user).to be_invalid
        expect(user.errors[:email]).to eq ["は不正な値です"]
        user.email = "ああexample@co.jp"
        expect(user).to be_invalid
        expect(user.errors[:email]).to eq ["は不正な値です"]
        user.email = "exampleco.jp"
        expect(user).to be_invalid
        expect(user.errors[:email]).to eq ["は不正な値です"]
      end
      it "重複したemailが存在する場合は登録できない" do
        user.save
        another_user.valid?
        expect(another_user.errors.full_messages).to eq ["メールアドレスはすでに存在します"]
      end
      it 'nameが255文字以上の時はの登録できない' do
        user.name = 'a' * 256
        expect(user).to be_invalid
        expect(user.errors[:name]).to eq ['は255文字以内で入力してください']
      end
      it 'nameが255文字以上の時はの登録できない' do
        user.email = 'a' * 246 + '@sample.jp'
        expect(user).to be_invalid
        expect(user.errors[:email]).to eq ['は255文字以内で入力してください']
      end
      it 'introductionが255文字以上の時はの登録できない' do
        user.introduction = 'a' * 256
        expect(user).to be_invalid
        expect(user.errors[:introduction]).to eq ['は255文字以内で入力してください']
      end
    end
  end
end
