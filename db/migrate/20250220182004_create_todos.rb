class CreateTodos < ActiveRecord::Migration[8.0]
  def change
    create_table :todos do |t|
      t.string :todoname
      t.text :tododescription

      t.timestamps
    end
  end
end
