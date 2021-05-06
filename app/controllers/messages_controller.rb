class MessagesController < ApplicationController
  def create
    @swap = Swap.find(params[:swap_id])
    @message = Message.new(message_params)
    @message.swap = @swap
    @message.user = current_user

    if @message.user_id == @swap.user_id
      @message.notify_message_receiver = true
      @message.save
    else
      @message.notify_message_owner = true
      @message.save
    end

    if @message.save
      SwapChannel.broadcast_to(
        @swap,
        render_to_string(partial: "message", locals: { message: @message })
      )
      redirect_to swap_path(@swap, anchor: "message-#{@message.id}")
    else
      render 'swaps/show'
    end
    authorize @message
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
