class BootstrapPaginationRenderer < WillPaginate::ActionView::LinkRenderer
    protected
    
    def page_number(page)
        if page != current_page
            tag(:li, link(page, page, :rel => rel_value(page)))
        else
            tag(:li, tag(:a, page), :class => "active")
        end
    end
    
    def gap
        tag(:li, tag(:a, '&hellip;'), :class => "disabled")
    end
    
    def previous_page
        num = @collection.current_page > 1 && @collection.current_page - 1
        
        previous_or_next_page num, '&laquo;'
    end
    
    
    def next_page
        num = @collection.current_page < @collection.total_pages && @collection.current_page + 1
        
        previous_or_next_page num, '&raquo;'
    end    
    
    def previous_or_next_page(page, label)
        if page
            tag(:li, link(label, page))
        else
            tag(:li, tag(:a, label), :class => 'disabled')
        end
    end
    
    def html_container(html)
        tag(:div, tag(:ul, html), :class => 'pagination pagination-centered')
    end

end
