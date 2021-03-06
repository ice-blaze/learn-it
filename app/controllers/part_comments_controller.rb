class PartCommentsController < ApplicationController

  before_action :authenticate_user!, except: :index

  def index
    @tutorial = Tutorial.find(params[:tutorial_id])
    @part = Part.find(params[:part_id])
    @parts = @tutorial.parts
    @comment = PartComment.new
    @comments =  @part.comments_top.paginate(page: params[:page], per_page: COMMENTS_PER_PAGE)
  end

  def create
    @tutorial = Tutorial.find(params[:tutorial_id])
    @part = Part.find(params[:part_id])
    @comment = @part.part_comments.create(comment_params)
    @comment.user = current_user
    @comment.like = 0
    @comment.dislike = 0
    if @comment.save
      redirect_to tutorial_part_part_comments_path(@tutorial,@part)
    else
      redirect_to tutorial_part_part_comments_path(@tutorial,@part), :flash => { :error => 'Part comment fail' }
    end
  end

  def update

  end

  def destroy
    PartComment.find(params[:id]).destroy
    redirect_to :back, flash: { info: 'Comment deleted' }
  end


  private
  def comment_params
    params.require(:part_comment).permit(:content, :part, :user)
  end
end
