require 'minitest/autorun'

require_relative '../lib/xml_transformer'

class TransformerTest < MiniTest::Unit::TestCase
  def test_transform
    xslt_path = File.join(File.dirname(__FILE__), "../public/stylesheets/transform.xsl")

    for i in 1..3
      doc_path = File.join(File.dirname(__FILE__), "fixtures/source#{i}.xml")
      transformed_doc = Transformer.transform(doc_path, xslt_path)
      # returns a set of Nokogiri::XML::Node
      all_first = transformed_doc.xpath("/people/person/name/first")
      all_last = transformed_doc.xpath("/people/person/name/last")
      assert_equal("Winnie", all_first.first.content)
      assert_equal("Jamie", all_first.last.content)
      assert_equal("the Pooh", all_last.first.content)
      assert_equal("the Weeh", all_last.last.content)
    end
  end
end