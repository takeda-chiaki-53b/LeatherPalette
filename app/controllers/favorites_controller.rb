class FavoritesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    current_user.favorite(@post)
  end
  # Postモデルからpost_idを探してくる。
  # ログイン中のユーザーと紐づけられたidを取ってくる。この時、user.rbに定義したメソッドを使用し、idの情報を保存する。

  def destroy
    @post = current_user.favorites.find(params[:id]).post
    current_user.unfavorite(@post)
  end
end
