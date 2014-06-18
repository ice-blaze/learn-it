class InterpreterGradesController < ApplicationController
  before_action :authenticate_user!

  def create
    #if vote with actual user exist, only update
    @interpreter = Interpreter.find(params[:interpreter_id])
    @grade = @interpreter.interpreter_grades.where(user_id: current_user.id).first

    if @grade.blank?
      @grade = InterpreterGrade.new
      @grade.user = current_user
      @grade.interpreter = @interpreter
    end

    @grade.grade = grade_params[:grade]

    if @grade.save
      redirect_to @interpreter
    else
      redirect_to @interpreter, :flash => { :info => 'Grade failed, value should be between 1 and 10 !' }
    end
  end

  def update
  end

  def destroy
  end

  private
  def grade_params
    params.require(:interpreter_grade).permit(:grade)
  end
end
