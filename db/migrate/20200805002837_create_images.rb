class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.string :name
      t.string :imageable_type
      t.integer :imageable_id
      t.string :path
      t.string :extension

      t.timestamps
    end
  end
end
