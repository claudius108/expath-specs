<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" version="2.0">

	<xsl:output method="html" />

	<xsl:param name="spec-names" />

	<xsl:variable name="spec-descriptions">
		<spec-descriptions>
			<spec-description spec-name="time">
				<p>
					As this is a work in progress, more details about it can be found at
					<a href="https://docs.google.com/document/d/11Vy3GIIpQD0UU2iCZRT-RR8nS2RYCOyF_fpjAPtQzbw/pub">Time Functions Comparison</a>.
				</p>
			</spec-description>
			<spec-description spec-name="datatype-conversion">
				<p>
					As this is a work in progress, more details about it can be found at
					<a href="https://docs.google.com/document/d/1aLoJHvzG9zFaTNM110xMjg-qMHT7vYtWpcBmYoawSJE/pub">Datatype Conversion Functions Comparison</a>.
				</p>
			</spec-description>
			<spec-description spec-name="digital-publishing">
				<p>
					As this is a work in progress, more details about it can be found at
					<a href="https://docs.google.com/document/d/1F4uoZ0HtQpSkIaWfTKi7oXzQYbvjaIGmxTL6RS5le3o/pub">Digital Publishing Functions Comparison</a>.
				</p>
			</spec-description>			
		</spec-descriptions>


	</xsl:variable>

	<xsl:template match="/">
		<xsl:result-document href="../index.html" method="html">
			<html>
				<head>
					<title>EXPath Specifications Index</title>
				</head>
				<body>
					<h2>EXPath Specifications Index</h2>
					<xsl:for-each select="tokenize($spec-names, ',')">
						<xsl:variable name="spec-name" select="." />
						<xsl:variable name="spec-dir" select="concat('../../', $spec-name, '/')" />
						<xsl:variable name="spec" select="document(concat($spec-dir, $spec-name, '.xml'))" />
						<xsl:variable name="spec-in-html-format-path" select="concat($spec-name, '/', $spec-name, '.html')" />
						<h4>
							<a href="{$spec-in-html-format-path}">
								<xsl:value-of select="concat('EXPath ', $spec//element()[local-name() = 'title'])" />
							</a>
						</h4>
						<h5>
							<xsl:value-of select="$spec//element()[local-name() = 'abstract']" />
							<xsl:copy-of select="$spec-descriptions//element()[@spec-name = $spec-name]/*" />
						</h5>
					</xsl:for-each>
				</body>
			</html>
		</xsl:result-document>
	</xsl:template>
</xsl:stylesheet>