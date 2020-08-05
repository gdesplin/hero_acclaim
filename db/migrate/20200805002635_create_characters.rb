class CreateCharacters < ActiveRecord::Migration[6.0]
  def change
    create_table :characters do |t|
      t.string :name
      t.string :email
      t.string :description
      t.string :resource_uri

      t.timestamps
    end
  end
end
