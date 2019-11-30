require 'rails_helper'

describe MessagesController do
  let(:group) { create(:group) }
  let(:user) { create(:user) }

  describe '#index' do
  # ログインしている場合
    context 'log in' do
      before do
        login user
        get :index, params: { group_id: group.id }
      end
      # アクション内で定義しているインスタンス変数があるか
      it 'assigns @message' do
        expect(assigns(:message)).to be_a_new(Message)
      end

      it 'assigns @group' do
        expect(assigns(:group)).to eq group
      end
      # 該当するビューが描画されているか
      it 'redners index' do
        expect(response).to render_template :index
      end
    end
    # ログインしていない場合
    context 'not log in' do
      before do
        get :index, params: { group_id: group.id }
      end
      
      # 意図したビューにリダイレクトできているか
      it 'redirects to new_user_session_path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end


  describe '#create' do
  # ログインしているかつ、保存に成功した場合
      let(:params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message) } }

      context 'log in' do
        before do
          login user
        end

        context 'can save' do
          subject {
            post :create,
            params: params
          }
          # # Messageモデルのレコードの総数が1個増えたかどうかを確かめる
          it 'count up message' do
            expect{ subject }.to change(Message, :count).by(1)
          end
          # # 意図した画面に遷移しているかどうかを確かめていきまし
          it 'redirects to group_messages_path' do
            subject
            expect(response).to redirect_to(group_messages_path(group))
          end
        end

        # ログインしているかつ、保存に失敗した場合 
        context 'can not save' do
          let(:invalid_params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message, body: nil, image: nil) } }

          subject {
            post :create,
            params: invalid_params
          }
          # # まず、メッセージの保存は行われなかったかどうかをテスト
          it 'does not count up' do
            expect{ subject }.not_to change(Message, :count)
          end

          it 'renders index' do
            subject
            expect(response).to render_template :index
          end
        end
      end
      # ログインしていない場合
      context 'not log in' do
        # # ログインしていない場合にcreateアクションをリクエストした際は、ログイン画面へとリダイレクト
        it 'redirects to new_user_session_path' do
          post :create, params: params
          expect(response).to redirect_to(new_user_session_path)
        end
      end
  end
end

