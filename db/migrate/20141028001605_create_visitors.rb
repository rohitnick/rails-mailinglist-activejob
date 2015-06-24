class CreateVisitors < ActiveRecord::Migration
  def change
    create_table :visitors do |t|
      t.string :email
      t.string :refer_token
      t.integer :refer_visit_count
      t.string :ip_address
      t.string :city
      t.references :referer

      t.timestamps null: false
    end
  end
end
