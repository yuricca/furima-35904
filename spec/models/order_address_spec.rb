require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '商品購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
      sleep 0.1
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_address).to be_valid
      end
      it 'buildingは空でも保存できること' do
        @order_address.building = ''
        expect(@order_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'post_codeが空だと保存できないこと' do
        @order_address.post_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code can't be blank")
      end
      it 'postal_codeが半角のハイフンを含んだ形式でないと保存できないこと' do
        @order_address.post_code = '123ー4567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
      end
      it 'postal_codeが全角では保存できないこと' do
        @order_address.post_code = '１２３-４５６７'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
      end
      it 'postal_codeが正しい桁数でないと保存できないこと' do
        @order_address.post_code = '1234-56789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
      end
      it 'prefecture_idが「---」では保存できないこと' do
        @order_address.prefecture_id = '1'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'townが空だと保存できないこと' do
        @order_address.town = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Town can't be blank")
      end
      it 'townが全角でないと保存できないこと' do
        @order_address.town = 'ｱｲｳｴｵ'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Town is invalid. Input full-width characters.')
      end
      it 'house_numberが空だと保存できないこと' do
        @order_address.house_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("House number can't be blank")
      end
      it 'phone_numberが空だと保存できないこと' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが全角数字だと保存できないこと' do
        @order_address.phone_number = '０９０１２３４５６７８'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is invalid')
      end
      it 'phone_numberが数字以外では保存できないこと' do
        @order_address.phone_number = 'あいうえおかきくけこ'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is invalid')
      end
      it 'userが紐づいていないと保存できないこと' do
        @order_address.user_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐づいていないと保存できないこと' do
        @order_address.item_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
      it 'tokenが空だと保存できないこと' do
        @order_address.token = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
