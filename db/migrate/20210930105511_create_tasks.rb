class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :content
      t.references :user, null: false, fareign_key: true

      t.timestamps
    end
  end
end
