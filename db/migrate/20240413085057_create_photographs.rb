class CreatePhotographs < ActiveRecord::Migration[7.1]
  def change
    create_table :photographs do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.datetime :created_at
    end
  end
end
