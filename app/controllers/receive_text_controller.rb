class ReceiveTextController < ApplicationController
  def index
    message_body = params["Body"]
    from_number = params["From"]
    logger.debug(message_body)

    # TODO verify parsing works correctly
    address = nil
    address_line = message_body[/Address:.*$/]
    if !address_line.nil?
      address = address_line.split(/Address:\s*/).second
      message_body = message_body.split(/"#{address_line}"/).second
    end

    @ticket = Ticket.create(description: message_body, address: address)
    logger.debug(@ticket.to_yaml)

    redirect_to controller: 'tickets', action: 'show', id: @ticket.id

    #render json: {message_body: message_body, from_number: from_number}.to_json()
    #format.all { render :nothing => true, :status => 200, :content_type => 'text/html'}

  end
end
