class BootstrapBreadcrumbBuilder < BreadcrumbsOnRails::Breadcrumbs::Builder
    def render
        @elements.collect do |element|
            render_element(element)
        end.join
    end
    
    def render_element(element)
        content =
                @context.link_to_unless_current(compute_name(element), compute_path(element), element.options) +
                @context.content_tag(:li, "/", :class => "divider")
        
        @context.content_tag :li, content        
    end
end
