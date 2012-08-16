class Kramdown::Converter::HtmlWithCut < Kramdown::Converter::Html
    def convert_cut(el, indent)
        "#{' '*indent}<a href=\"#{@options[:cut]}\" class=\"btn\">Read more &raquo;</a>"
    end
end
