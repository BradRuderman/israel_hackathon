class AddAddressToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :address, :string
  end
end
