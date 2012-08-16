class Post < ActiveRecord::Base
    attr_accessible :body, :published, :title, :tags_list
    belongs_to :user
    has_and_belongs_to_many :tags
    has_many :comments
    
    validates_presence_of :title, :body, :user
    
    scope :visible_to_user, lambda { |user|
      
        if user.nil?
            self.where("published = ?", true)
        else
            self.where("published = ? OR user_id = ?", true, user.id)
        end
    }
    
    def tags_list
        tags.map(&:name).join(", ")
    end
    
    def tags_list=(list)
        self.tags = list.split(",").map(&:strip).map { |t| Tag.find_or_create_by_name(t) }
    end
end
