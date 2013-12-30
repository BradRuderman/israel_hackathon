class Ticket < ActiveRecord::Base
	has_attached_file :scan
end
