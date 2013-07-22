<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

	<xsl:output method="text" />

	<xsl:param name="java-package-name" />
	<xsl:param name="expath-spec-id" />

	<xsl:variable name="java-lib-dir"
		select="concat('../../expath-libs/', $expath-spec-id, '/src/main/java/org/expath/', $java-package-name, '/')" />
	<xsl:variable name="java-package-declaration" select="concat('package org.expath.', $java-package-name, ';')" />

	<xsl:variable name="java-end-of-instruction-line">
		<xsl:text>";
</xsl:text>
	</xsl:variable>

	<xsl:template match="/">
		<xsl:variable name="module-namespace">
			<xsl:copy-of select="//element()[@id = 'module-namespace']" />
		</xsl:variable>
		<xsl:variable name="module-prefix">
			<xsl:copy-of select="//element()[@id = 'module-prefix']" />
		</xsl:variable>

		<xsl:result-document href="{concat($java-lib-dir, 'ErrorMessages.java')}" method="text">
			<xsl:value-of select="$java-package-declaration" />
			<xsl:text>
      
</xsl:text>
			<xsl:text>public class ErrorMessages {
</xsl:text>
			<xsl:for-each select="//element()[@id = 'summary-of-error-conditions']/*">
				<xsl:text>      public static String </xsl:text>
				<xsl:value-of select="replace(@key, ':', '_')" />
				<xsl:text> = "</xsl:text>
				<xsl:value-of select="concat(@key, ': ', .)" />
				<xsl:text>";
</xsl:text>
			</xsl:for-each>
			<xsl:text>}</xsl:text>
		</xsl:result-document>

		<xsl:result-document href="{concat($java-lib-dir, 'ModuleDescription.java')}" method="text">
			<xsl:value-of select="$java-package-declaration" />
			<xsl:text>

import java.io.FileInputStream;
import java.util.Properties;
</xsl:text>
			<xsl:text>
/**
 * Module description.
 * 
 * @author Claudius Teodorescu &lt;claudius.teodorescu@gmail.com&gt;
 */      
</xsl:text>
			<xsl:text>public class ModuleDescription {
    public final static Properties libProperties = new Properties();
    static {
        FileInputStream propertiesFis;
        try {
            propertiesFis = new FileInputStream("lib.properties");
            libProperties.load(propertiesFis);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public final static String VERSION = libProperties.getProperty("lib-version");
</xsl:text>
			<xsl:text>      public final static String NAMESPACE_URI = "</xsl:text>
			<xsl:value-of select="concat($module-namespace, $java-end-of-instruction-line)" />
			<xsl:text>      public final static String PREFIX = "</xsl:text>
			<xsl:value-of select="concat($module-prefix, $java-end-of-instruction-line)" />
			<xsl:text>      public final static String MODULE_NAME = "</xsl:text>
			<xsl:value-of select="concat('EXPath ', //element()[local-name() = 'title'], $java-end-of-instruction-line)" />
			<xsl:text>      public final static String MODULE_DESCRIPTION = "</xsl:text>
			<xsl:value-of select="concat('A ', //element()[@id = 'module-description'], $java-end-of-instruction-line)" />
			<xsl:text>}
</xsl:text>
		</xsl:result-document>

	</xsl:template>
</xsl:stylesheet>