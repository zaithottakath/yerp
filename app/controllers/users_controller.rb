class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @comments = Comment.find_comments_by_user(@user).paginate(page: params[:page], per_page: 10)
  end
end
