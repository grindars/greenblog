module ApplicationHelper    
    def title(page_title = nil)
        if page_title.nil?
            content_for :title
        else
            content_for :title do
                page_title
            end
            
            page_title
        end
    end
        
    def title?
        content_for? :title
    end
    
    def markdown_to_html(markdown, cut = nil)
        doc = Kramdown::Document.new(markdown, :input => :KramdownWithCut, :cut => cut)
        
        output, warnings = Kramdown::Converter::HtmlWithCut.convert(doc.root, doc.options)
        
        output.html_safe
    end
    
end
