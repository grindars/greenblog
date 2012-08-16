class CreatePostsTagsJoinTable < ActiveRecord::Migration
    def change
        create_table :posts_tags, :id => false do |t|
            t.integer :post_id, :null => false
            t.integer :tag_id, :null => false
        end
        
        add_index :posts_tags, [ :post_id, :tag_id ], :name => "posts_tags_index", :unique => true
    end
end
