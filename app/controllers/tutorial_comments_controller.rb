class TutorialCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @tutorial = Tutorial.find(params[:tutorial_id])
    @comment = @tutorial.tutorial_comments.create(comment_params)
    @comment.user = current_user
    @comment.like = 0
    @comment.dislike = 0
    if @comment.save
      redirect_to tutorial_path(@tutorial)
    else
      redirect_to tutorial_path(@tutorial), :flash => { :error => 'Tutorial comment fail' }
    end
  end

  def update

  end

  private
  def comment_params
    params.require(:tutorial_comment).permit(:content, :tutorial_id, :user_id)
  end
end
