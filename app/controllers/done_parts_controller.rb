class DonePartsController < ApplicationController
  require 'li_load_inputs'
  before_action :authenticate_user!

  def create
    # render plain: done_params.inspect
    @tutorial = Tutorial.find(params[:tutorial_id])
    @part = Part.find(params[:part_id])

    # create functions
    LIFunction::reset_functions
    @tutorial.interpreter.functions.each do |f|
      eval("def #{f.name}(line)\r\n#{f.content}\r\nend")
      LIFunction.new(Regexp.new(f.regex),method(f.name),f.name=='nothing_func'?false:true)
    end

    # set token
    Scope::set_tokens(Regexp.new(@tutorial.interpreter.open_token), Regexp.new(@tutorial.interpreter.close_token))

    # input in splitted line
    signature_part = @part.signature.lines().map(&:chomp)
    signature_part = load_inputs(signature_part)
    signature_inputs = load_inputs(params[:signature].lines().map(&:chomp))

    # render plain: signature_part.inspect+"\n\n"+signature_inputs.inspect
    # return

    if signature_inputs != signature_part || signature_inputs.blank?
      redirect_to [@tutorial,@part], :flash => { :error => 'Signature doesn\'t match, retry !'}
      return
    end

    @done_part = DonePart.new
    @done_part.user = current_user
    @done_part.part = @part
    # no checks in the case where the user try a lot of request and uniquness fail
    @done_part.save

    @parts = @tutorial.parts
    @next_part = @parts[@parts.index(@part)+1]
    redirect_to [@tutorial,@next_part], :flash => { :info => 'Good job you are now in the next part !'}
  end
end
