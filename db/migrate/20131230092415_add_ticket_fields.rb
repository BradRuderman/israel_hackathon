class AddTicketFields < ActiveRecord::Migration
 def self.up
    add_attachment :tickets, :photo
    add_column :tickets, :description, :string
 	add_column :tickets, :status, :string
  	add_column :tickets, :priority, :string
	add_column :tickets, :category, :string
	add_column :tickets, :private, :string
    add_column :tickets, :lat, :decimal, :precision => 9, :scale => 8
    add_column :tickets, :long, :decimal, :precision => 9, :scale => 8
  end

  def self.down
    remove_attachment :tickets, :photo
    remove_column :description, :priority, :status, :category, :private, :lat, :long
  end
end
