class PartsController < ApplicationController
  def show
    @part = Part.find(params[:id])
  end

  def create
    @tutorial = Tutorial.find(params[:tutorial_id])
    @part = @tutorial.parts.create(part_params)
    redirect_to edit_tutorial_path(@tutorial)
  end

  def edit
  end

  def delete
  end

  private
  def part_params
    params.require(:part).permit(:title, :content, :signature, :tutorial)
  end
end