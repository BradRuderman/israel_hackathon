class RenameLongToLon < ActiveRecord::Migration
  def change
    rename_column :tickets, :long, :lon
  end
end
