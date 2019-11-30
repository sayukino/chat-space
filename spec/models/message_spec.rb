require 'rails_helper'

describe Message do
  describe '#create' do
    context 'can save' do
  # メッセージがあれば保存できる
      it "can be saved with only a body" do
        expect(build(:message, image: nil)).to be_valid
      end
      
  # 画像があれば保存できる
      it "can be saved only with image" do
        expect(build(:message, body: nil)).to be_valid
      end
  # メッセージと画像があれば保存できる
      it "can be saved with body and image" do
        expect(build(:message)).to be_valid
      end
    end

    # メッセージも画像も無いと保存できない
    context 'cannot save' do
      it "cannot be saved if body and image don't exists" do
        message = build(:message, body: nil, image: nil)
        message.valid?
        expect(message.errors[:body]).to include('を入力してください')
      end

# group_idが無いと保存できない
      it "cannot be saved if group_id doesn't exist" do
        message = build(:message, group_id: nil)
        message.valid?
        expect(message.errors[:group]).to include('を入力してください')
      end
    
# user_idが無いと保存できない
      it "cannot be saved without a user-id" do
        message = build(:message, user_id: nil)
        message.valid?
        expect(message.errors[:user]).to include('を入力してください')
      end
    end
  end
end
   
