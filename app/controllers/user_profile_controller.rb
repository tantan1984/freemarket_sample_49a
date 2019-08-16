class UserProfileController < UsersController
  def new
    if user_signed_in?
      @user_profile = current_user
    else
      redirect_to root_path
    end
    # @subjects= ["マイページ"]
    # @subjects2= ["お知らせ", "やることリスト", "いいね！一覧", "出品する", "出品した商品 - 出品中", "出品した商品 - 取引中", "出品した商品 - 売却済み", "購入した商品 - 取引中", "購入した商品 - 過去の取引", "ニュース一覧 評価一覧", "ガイド お問い合わせ"]
    # @subjects3=["売上・振込申請", "ポイント"]
    # @subjects4=["プロフィール", "発送元・お届け先住所変更", "支払い方法", "メール/パスワード", "本人情報", "電話番号の確認", "ログアウト"]
    # @bigcategories = Category.where(parent_id:nil, child_id:nil)
  end

  def update
    current_user.update(profile_params)
    redirect_to root_path
  end
  
  private
  def profile_params
    params.require(:user).permit(:nickname,:profile)
  end
end
