class ReceiveTextController < ApplicationController
  def index
    message_body = params["Body"]
    from_number = params["From"]

    # TODO verify parsing works correctly
    address = nil
    address_line = message_body[/address:.*/]
    if !address_line.nil?
      address = address_line.split(/address:\s*/).second
      message_body = message_body.split(/address:.*/).second
    end

    @ticket = Ticket.create(description: message_body, address: address)

    redirect_to controller: 'tickets', action: 'show', id: @ticket.id

    #render json: {message_body: message_body, from_number: from_number}.to_json()
    #format.all { render :nothing => true, :status => 200, :content_type => 'text/html'}

  end
end
