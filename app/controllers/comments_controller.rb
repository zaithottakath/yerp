class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_business

  def create
    #build_from(obj, user_id, rating, comment)
    @comment = Comment.build_from(@business, current_user.id,
      params[:comment][:rating], params[:comment][:body])
    if @comment.save
      flash[:notice] = "Comment has been created."
      redirect_to @business
    else
      flash[:alert] = "Comment has not been created."
      render :template => "businesses/show"
    end
  end

  private

    def find_business
      @business = Business.find(params[:business_id])
    end

end
