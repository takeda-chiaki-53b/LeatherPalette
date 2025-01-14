require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションチェック' do
    it 'userモデルに定義したバリデーションが全て機能しているか' do
      user = build(:user)
      expect(user).to be_valid
      expect(user.errors).to be_empty
    end

    # ユニークバリデーションのチェック

    it '同じメールアドレスがあると無効になること' do
      user1 = create(:user)
      user2 = build(:user, email: user1.email)
      expect(user2).to be_invalid
      expect(user2.errors[:email]).to include("：このメールアドレスは使用できません。別のメールアドレスをご入力ください。")
    end

    it '同じreset_password_tokenがあると無効になること' do
      user1 = create(:user, reset_password_token: 'token123')
      user2 = build(:user, reset_password_token: 'token123')
      expect(user2).to be_invalid
      expect(user2.errors[:reset_password_token]).to include("はすでに存在します")
    end

    # 字数バリデーションのチェック

    it '名前が51文字以上だと無効であること' do
      user = build(:user)
      user.name = "a" * 51
      expect(user).to be_invalid
      expect(user.errors[:name]).to include('は50文字以内で入力してください')
    end

    it 'パスワードが8文字未満だと無効になること' do
      user = build(:user)
      user.password = "a" * 7
      expect(user).to be_invalid
      expect(user.errors[:password]).to include('は8文字以上で入力してください')
    end

    # 確認用パスワードのバリデーションチェック

    it 'パスワードと確認用パスワードが一致しないと無効になること' do
      user = build(:user, password: 'password123', password_confirmation: 'different')
      expect(user).to be_invalid
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end
  end
end
