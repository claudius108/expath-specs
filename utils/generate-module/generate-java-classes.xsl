<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

  <xsl:output method="text" />

  <xsl:variable name="java-end-of-line">
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
    <xsl:result-document href="ErrorMessages.java" method="text">
      <xsl:text>package org.expath.crypto;
      
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
    <xsl:result-document href="ExpathCryptoModule22.java" method="text">
      <xsl:text>package org.expath.crypto;
    
import java.io.FileInputStream;
import java.util.Properties;
</xsl:text>
      <xsl:text>
/**
 * Implements the module definition.
 * 
 * @author Claudius Teodorescu &lt;claudius.teodorescu@gmail.com&gt;
 */      
</xsl:text>
      <xsl:text>public class ExpathCryptoModule22 {
    public final static Properties moduleProperties = new Properties();
    static {
        FileInputStream propertiesFis;
        try {
            propertiesFis = new FileInputStream("module.properties");
            moduleProperties.load(propertiesFis);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public final static String VERSION = moduleProperties.getProperty("module-version");
</xsl:text>
      <xsl:text>      public final static String NAMESPACE_URI = "</xsl:text>
      <xsl:value-of select="concat($module-namespace, $java-end-of-line)" />
      <xsl:text>      public final static String PREFIX = "</xsl:text>
      <xsl:value-of select="concat($module-prefix, $java-end-of-line)" />
      <xsl:text>      public final static String MODULE_NAME = "</xsl:text>
      <xsl:value-of select="concat('EXPath ', //element()[local-name() = 'title'], $java-end-of-line)" />
      <xsl:text>      public final static String MODULE_DESCRIPTION = "</xsl:text>
      <xsl:value-of select="concat('A ', //element()[@id = 'module-description'], $java-end-of-line)" />
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
  </xsl:template>
</xsl:stylesheet>