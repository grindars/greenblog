xml.instruct! :xml, :version => "1.0"

xml.rss :version => "2.0" do
    xml.channel do
        xml.title "Grindars' Blog"
        xml.description @description
        xml.link @link
        
        for post in @posts
            xml.item do
                xml.title post.title
                xml.description markdown_to_html(post.body)                
                xml.pubDate post.created_at.to_s :rfc822
                xml.link post_url(post)
                xml.guid post.id
            end
        end
    end
end
