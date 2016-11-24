<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
  exclude-result-prefixes="#all"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xpath-default-namespace="http://www.w3.org/1999/xhtml"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:xh="http://www.w3.org/1999/xhtml"
  version="2.0">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p><xd:b>Created on:</xd:b> Nov 14, 2016</xd:p>
      <xd:p><xd:b>Author:</xd:b> mholmes</xd:p>
      <xd:p>The objective of this file is to process the entire state 
      of the TCCD repository at a specific revision and generate 
      various views of the state of play with regard to processing
      and completion.</xd:p>
    </xd:desc>
  </xd:doc>
  
<!--  Bring in our utilities. -->
  <xsl:include href="utilities_module.xsl"/>
  
<!--  Output is always XHTML5. -->
  <xsl:output method="xhtml" encoding="UTF-8" indent="yes" normalization-form="NFC"
    exclude-result-prefixes="#all" omit-xml-declaration="yes"/>
  
<!--  Some variables for documents, paths and constants. -->
<!-- Wherever this gets called from, we want to do things relative to its actual location. -->
  <xsl:param name="baseDir" select="replace(document-uri(/), concat(tokenize(document-uri(/), '/')[last()], '$'), '')"/>
  
<!--  Current date-time in various formats. -->
  <xsl:variable name="currDateTimeHuman" select="format-dateTime(current-dateTime(),'[D] [MNn] at [h1]:[m01] [P]')"/>
  <xsl:variable name="currDateW3C" as="xs:string" select="format-date(current-date(), '[Y0001]-[M01]-[D01]')"/>
  <xsl:variable name="currDateTime" as="xs:dateTime" select="current-dateTime()"/>
  
<!--  The root for all our documents. -->
  <xsl:variable name="docRoot" select="concat($baseDir, '/../../data')"/>
  
<!--  The utilities folder, where various things are stored including collections of files. -->
  <xsl:variable name="utilitiesDir" select="concat($baseDir, '/../utilities')"/>
  
<!--  Some collections files created by a Python script. -->
  <xsl:variable name="origHocrCollectionFile" select="concat($utilitiesDir, '/origHocrFiles.xml')"/>
  <xsl:variable name="origHocrCollection" select="doc($origHocrCollectionFile)"/>
  <xsl:variable name="editedHocrCollectionFile" select="concat($utilitiesDir, '/editedHocrFiles.xml')"/>
  <xsl:variable name="editedHocrCollection" select="doc($editedHocrCollectionFile)"/>
  <xsl:variable name="teiCollectionFile" select="concat($utilitiesDir, '/teiFiles.xml')"/>
  <xsl:variable name="teiCollection" select="doc($teiCollectionFile)"/>
  
<!--  Various collections already generated by a Python script run by the ant task. -->
  <!--<xsl:variable name="origHocrFiles" select="collection(concat($utilitiesDir, '/origHocrFiles.xml'))"/>
  <xsl:variable name="editedHocrFiles" select="collection(concat($utilitiesDir, '/editedHocrFiles.xml'))"/>-->
  <xsl:variable name="teiDebateFiles" select="collection(concat($utilitiesDir, '/teiFiles.xml'))"/>
  <xsl:variable name="teiPages" select="$teiDebateFiles//tei:surface"/>
  <xsl:variable name="teiPagesWithNameTagging" select="$teiDebateFiles[descendant::tei:body/descendant::tei:persName[@ref]]//tei:surface"/>
  
<!-- Root template. -->
  <xsl:template match="/">
    <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;
            </xsl:text>
    <html lang="en" xmlns="http://www.w3.org/1999/xhtml" id="diagnostics">
      <head>
        <title>The Confederation Debates: Diagnostics <xsl:value-of select="$currDateTimeHuman"/></title>
      </head>
      
      <body>
          <h1>The Confederation Debates: Diagnostics <xsl:value-of select="$currDateTimeHuman"/></h1>
        <div>
          <table>
            <tbody>
              <tr>
                <td>Original scanned pages:</td>
                <td id="hocrPagesRaw"><xsl:value-of select="count($origHocrCollection/descendant::*:doc)"/></td>
              </tr>
              <tr>
                <td>Edited HOCR pages:</td>
                <td id="hocrPagesEdited"><xsl:value-of select="count($editedHocrCollection/descendant::*:doc)"/></td>
              </tr>
              <tr>
                <td>Pages in TEI:</td>
                <td id="pagesInTei"><xsl:value-of select="count($teiPages)"/></td>
              </tr>
              <tr>
                <td>Pages in TEI with names tagged:</td>
                <td id="teiPagesNamesTagged"><xsl:value-of select="count($teiPagesWithNameTagging)"/></td>
              </tr>
            </tbody>
          </table>
        </div>
      </body>
    </html>
  </xsl:template>
  
  
</xsl:stylesheet>