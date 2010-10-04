require 'xml/libxml'

module Fabulator
  XML_NS = "http://dh.tamu.edu/ns/fabulator/xml/1.0#"
  module Xml
    module Actions
      class Lib < Fabulator::TagLib

        namespace XML_NS

        has_type :document do
          going_to [ FAB_NS, 'string' ] do
            weight 1.0
            converting do |x|
              x.root.value.to_s
            end
          end
 
          coming_from [ FAB_NS, 'string' ] do
            weight 1.0
            converting do |x|
              (x.root.anon_node(LibXML::XML::Document.string(x.root.value), [ XML_NS, 'document' ]) rescue nil)
            end
          end
        end

        has_type :node do
          going_to [ FAB_NS, 'string' ] do
            weight 1.0
            converting do |x|
              x.root.anon_node(
                (
                  x.root.value.is_a?(LibXML::XML::Node) ? x.root.value.content :
                  x.root.value.is_a?(LibXML::XML::Attr) ? x.root.value.value :
                  x.root.value.to_s
                ), [ FAB_NS, 'string' ]
              )
            end
          end
        end

        function 'parse-string', [ XML_NS, 'document' ] do |ctx, args|
          args[0].collect { |a|
            (ctx.root.anon_node(LibXML::XML::Document.string(a.to_s), [ XML_NS, 'document' ]) rescue nil)
          } - [ nil ]
        end

        function 'path', [ XML_NS, 'node' ] do |ctx, args|
          xpath_ns = [ ]
          ctx.each_namespace do |p,h|
            xpath_ns << "#{p}:#{h}"
          end
          res = [ ]
          nodes = [ ]
          args[0].each { |a|
            args[1].each{ |x|
              nodes = nodes + (a.to([XML_NS,'document']).value.find(x.to_s, xpath_ns).to_a rescue [])
            }
          }
#          return nodes - [ nil ]
          nodes.each {|ob|
            if !ob.nil?
              ob.each { |node|
                res << ctx.root.anon_node(node, [ XML_NS, 'node' ])
              }
            end
          }
          res - [ nil ]
        end

      end
    end
  end
end
