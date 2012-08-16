class Kramdown::Parser::KramdownWithCut < Kramdown::Parser::Kramdown
    def handle_extension(name, opts, body, type)
        case name
        when 'cut'                        
            unless @options[:cut].empty?
                @tree.children << Element.new(:cut, body, nil, :category => type)
                throw :stop_block_parsing
            end
            
            true
        else
            super
        end
    end
end

Kramdown::Options.define(:cut, String, "", "Parse up to cut tag") unless Kramdown::Options.defined? :cut
