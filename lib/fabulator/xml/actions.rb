require 'xml/libxml'

module Fabulator
  XML_NS = "http://dh.tamu.edu/ns/fabulator/xml/1.0#"
  module Xml
    module Actions
      class Lib
        include Fabulator::ActionLib

        register_namespace XML_NS

        register_type 'document', {
          :to => [
            { :type => [ FAB_NS, 'string' ],
              :weight => 1.0,
              :convert => Proc.new { |x| x.anon_node(x.value.to_s, [ FAB_NS, 'string' ]) }
            }
          ],
          :from => [
            { :type => [ FAB_NS, 'string' ],
              :weight => 1.0,
              :convert => Proc.new { |x| (x.anon_node(LibXML::XML::Document.string(x.value), [ XML_NS, 'document' ]) rescue nil) }
            }
          ]
        }

        register_type 'node', {
          :to => [
            { :type => [ FAB_NS, 'string' ],
              :weight => 1.0,
              :convert => Proc.new { |x| x.anon_node(x.value.content, [ FAB_NS, 'string' ]) }
            }
          ]
        }

        function 'parse-string', [ XML_NS, 'document' ] do |ctx, args, ns|
          args[0].collect { |a|
            (ctx.anon_node(LibXML::XML::Document.string(a.to_s), [ XML_NS, 'document' ]) rescue nil)
          } - [ nil ]
        end

        function 'path', [ XML_NS, 'node' ] do |ctx, args, ns|
          xpath_ns = [ ]
          ns.each_pair do |p,h|
            xpath_ns << "#{p}:#{h}"
          end
          res = [ ]
          nodes = [ ]
          args[0].each { |a|
            args[1].each{ |x|
              nodes = nodes + (a.to([XML_NS,'document']).value.find(x.to_s, xpath_ns).to_a rescue [])
            }
          }
          return nodes - [ nil ]
          nodes.each {|ob|
            if !ob.nil?
              ob.each { |node|
                res << node.content
              }
            end
          }
          res - [ nil ]
        end

      end
    end
  end
end
