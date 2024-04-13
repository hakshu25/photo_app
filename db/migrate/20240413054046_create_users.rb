class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :account_id, index: { unique: true }
      t.string :password_digest
      t.datetime :created_at
    end
  end
end
