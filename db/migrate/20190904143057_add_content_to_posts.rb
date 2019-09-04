class AddContentToPosts < ActiveRecord::Migration[6.0]
  def change
    change_table :posts do |t|
      t.text :content
      t.belongs_to :user
    end
  end
end
