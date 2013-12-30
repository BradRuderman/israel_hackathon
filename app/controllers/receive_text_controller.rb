class ReceiveTextController < ApplicationController
  def index
    # let's pretend that we've mapped this action to
    # http://localhost:3000/sms in the routes.rb file

    message_body = params["Body"]
    from_number = params["From"]
    logger.debug(message_body)
    @ticket = Ticket.create(description: message_body)
    logger.debug(@ticket.to_yaml)
    redirect_to controller: 'tickets', action: 'show', id: @ticket.id

    #render json: {message_body: message_body, from_number: from_number}.to_json()
    #format.all { render :nothing => true, :status => 200, :content_type => 'text/html'}

  end
end
