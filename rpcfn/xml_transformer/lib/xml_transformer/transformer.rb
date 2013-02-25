require 'nokogiri'

module XmlTransformer
  class Transformer
    def self.transform(doc_path, xslt_path)
      doc = Nokogiri::XML(File.read(doc_path))
      xslt = Nokogiri::XSLT(File.read(xslt_path))
      # returns a Nokogiri::XML::Document
      xslt.transform(doc)
    end
  end
end