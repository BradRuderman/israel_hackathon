class AddTicketFields < ActiveRecord::Migration
 def self.up
    add_column :tickets, :description, :string
    add_column :tickets, :status, :string
    add_column :tickets, :priority, :string
    add_column :tickets, :category, :string
    add_column :tickets, :private, :string
    add_column :tickets, :lat, :decimal, :precision => 10, :scale => 7
    add_column :tickets, :long, :decimal, :precision => 10, :scale => 7
    add_column :tickets, :image, :binary
  end

  def self.down
    remove_column :description, :priority, :status, :category, :private, :lat, :long, :image
  end
end
