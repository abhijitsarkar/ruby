<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" encoding="UTF-8" />
	<!-- match the node that has a name starting with 'first' -->
	<xsl:template match="node()[starts-with(name(), 'first')]">
		<xsl:element name="people">
			<xsl:element name="person">
				<xsl:element name="name">
					<xsl:element name="first">
						<xsl:value-of select="." />
					</xsl:element>
					<xsl:element name="last">
						<xsl:value-of select="following-sibling::*[1]" />
					</xsl:element>
				</xsl:element>
			</xsl:element>
		</xsl:element>
		<xsl:apply-templates />
	</xsl:template>
	<!-- stop the processor walking the rest of the tree and hitting text nodes -->
	<xsl:template match="text()|@*" />
</xsl:stylesheet>