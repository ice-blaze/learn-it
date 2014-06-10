class PartCommentVotesController < ApplicationController
  before_action :authenticate_user!

  def create
    @tutorial = Tutorial.find(params[:tutorial_id])
    @part = Part.find(params[:part_id])
    @comment = PartComment.find(params[:part_comment_id])
    @vote = PartCommentVote.create(vote_params)
    @vote.user = current_user
    @vote.part_comment = @comment

    # no checks in the case where the user try a lot of request and uniquness fail
    @vote.save
    redirect_to tutorial_part_part_comments_path(@tutorial,@part)
  end

  def update
    @vote = PartCommentVote.find(params[:id])
    @tutorial = Tutorial.find(params[:tutorial_id])
    @part = Part.find(params[:part_id])

    if @vote.update(vote_params)
      redirect_to tutorial_part_part_comments_path(@tutorial,@part)
    else
      redirect_to tutorial_part_part_comments_path(@tutorial,@part), :flash => { :info => 'Change vote FAILED !' }
    end
  end

  def destroy

  end

  private
  def vote_params
    params.require(:part_comment_vote).permit(:positive)
  end
end
