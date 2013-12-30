require "base64"

class ImageController < ApplicationController
	def index
		t = Ticket.find(params[:id])
	    send_data Base64.decode64(t.image), :type => 'image/jpeg',:disposition => 'inline'
	end

	def test
	end
end
