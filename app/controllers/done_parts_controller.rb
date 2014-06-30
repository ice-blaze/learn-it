class DonePartsController < ApplicationController
  require 'li_load_inputs'

  def create
    # render plain: done_params.inspect
    @tutorial = Tutorial.find(params[:tutorial_id])
    @part = Part.find(params[:part_id])

    # create functions
    LIFunction::reset_functions
    @tutorial.interpreter.functions.each do |f|
      #thread is there to limit eval abuse
      eval("def #{f.name}(line)
          thread = Thread.start {
          $SAFE = 3
          #{f.content}
          }
          thread.join
          thread[:return]
          end")
      LIFunction.new(Regexp.new(f.regex),method(f.name),f.name=='nothing_func'?false:true,f.loop).taint
    end

    # set token
    LIScope::set_tokens(Regexp.new(@tutorial.interpreter.open_token), Regexp.new(@tutorial.interpreter.close_token))

    # input in splitted line
    signature_part = @part.signature.lines().map(&:chomp)
    signature_part = load_inputs(signature_part)[:signature]

    result_inputs = load_inputs(params[:signature].lines().map(&:chomp))

    signature_inputs = result_inputs[:signature]
    output_inputs = result_inputs[:output]

    # render plain: signature_part.inspect+"\n\n"+signature_inputs.inspect
    # return
    unless output_inputs.is_a? Array
      return redirect_to [@tutorial,@part], flash: { :error => "An bad error showed up !\nResult : "+output_inputs.to_s}
    end

    if signature_inputs != signature_part || signature_inputs.blank?
      redirect_to [@tutorial,@part], :flash => { :error => "Signature doesn't match, retry !\nOutput is :\n"+output_inputs.try(:join,'\n')}
      return
    end


    unless current_user.blank?
      @done_part = DonePart.new
      @done_part.user = current_user
      @done_part.part = @part
      # no checks in the case where the user try a lot of request and uniquness fail
      @done_part.save
    end

    @parts = @tutorial.parts_ordered
    @next_part = @parts[@parts.index(@part)+1]

    redirect_to [@tutorial,@next_part], flash: { info: "Good job you are now in the next part !\nOutput was :\n"+output_inputs.try(:join,'\n') }
  end
end
