class CreateComments < ActiveRecord::Migration
    def change
        create_table :comments do |t|
            t.references :user, :null => false
            t.text :body, :null => false
            t.references :post, :null => false

            t.timestamps
        end
        
        add_index :comments, :user_id
        add_index :comments, :post_id
    end
end
