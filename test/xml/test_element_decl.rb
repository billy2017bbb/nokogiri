require File.expand_path(File.join(File.dirname(__FILE__), '..', "helper"))

module Nokogiri
  module XML
    class TestElementDecl < Nokogiri::TestCase
      def setup
        super
        @xml = Nokogiri::XML(<<-eoxml)
<?xml version="1.0"?><?TEST-STYLE PIDATA?>
<!DOCTYPE staff SYSTEM "staff.dtd" [
   <!ELEMENT br EMPTY>
   <!ATTLIST br width CDATA "0">
   <!ATTLIST br height CDATA "0">
]>
</root>
        eoxml
        @elements = @xml.internal_subset.children.find_all { |x|
          x.type == 15
        }
      end

      def test_type
        assert_equal 15, @elements.first.type
      end

      def test_class
        assert_instance_of Nokogiri::XML::ElementDecl, @elements.first
      end

      def test_attributes
        assert_equal 2, @elements.first.attribute_nodes.length
        assert_equal 'width', @elements.first.attribute_nodes.first.name
      end
    end
  end
end