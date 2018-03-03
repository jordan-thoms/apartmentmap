class AddExpiresToListings < ActiveRecord::Migration[5.2]
  def change
    change_table :listings do |t|
      t.datetime :expires_at
      t.datetime :invalid_at
    end
  end
end
