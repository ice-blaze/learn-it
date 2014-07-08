class DonePartsController < ApplicationController
  require 'li_load_inputs'

  def create
    # render plain: done_params.inspect
    @tutorial = Tutorial.find(params[:tutorial_id])
    @part = Part.find(params[:part_id])

    open_token = @tutorial.interpreter.open_token
    close_token = @tutorial.interpreter.close_token
    functions = @tutorial.interpreter.functions_ordered.reverse

    # input in splitted line
    signature_part = @part.signature.lines().map(&:chomp)

    begin
      signature_part = load_inputs(signature_part,functions,open_token,close_token)[:signature]

      result_inputs = load_inputs(params[:signature].lines().map(&:chomp),functions,open_token,close_token)

      signature_inputs = result_inputs[:signature]
      output_inputs = result_inputs[:output]
    rescue Exception => e
      redirect_to [@tutorial,@part, code: params[:signature]], flash: { error: "An bad error showed up !\nResult : "+e.message.to_s}
      return
    end

    if signature_inputs != signature_part || signature_inputs.blank?
      redirect_to [@tutorial,@part,output: output_inputs, signature: false, code: params[:signature]], :flash => { :error => "Signature doesn't match, retry !"}
      return
    end

    unless current_user.blank?
      @done_part = DonePart.new
      @done_part.user = current_user
      @done_part.part = @part
      # no checks in the case where the user try a lot of request and uniquness fail
      @done_part.save
    end

    # @parts = @tutorial.parts_ordered
    # @next_part = @parts[@parts.index(@part)+1]

    redirect_to [@tutorial,@part,output: output_inputs, signature: true, code: params[:signature]] , flash: { info: "Good job !"}
  end
end
