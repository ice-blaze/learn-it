class PartsController < ApplicationController
  before_action :authenticate_user!, except: :show

  def show
    @tutorial = Tutorial.find(params[:tutorial_id])
    @part = Part.find(params[:id])
    @parts = @tutorial.parts
  end

  def create
    tutorial = Tutorial.find(params[:tutorial_id])
    tutorial.parts.create(part_params)
    redirect_to edit_tutorial_path(tutorial)
  end

  def edit
  end

  def update
    tutorial = Tutorial.find(params[:tutorial_id])
    part = Part.find(params[:id])

    if part.update(part_params)
      redirect_to edit_tutorial_path(tutorial)
    else
      render 'edit'
    end
  end

  def delete
  end

  private
  def part_params
    params.require(:part).permit(:title, :content, :signature, :tutorial)
  end
end
