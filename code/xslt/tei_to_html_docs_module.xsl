<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="#all"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:hcmc="http://hcmc.uvic.ca/ns"
    version="2.0">
    
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> January 11, 2017.</xd:p>
            <xd:p><xd:b>Author:</xd:b> <xd:a href="pers:HOLM3">mholmes</xd:a></xd:p>
            <xd:p>
                This module identifies the collection of TEI documents which need
                to be converted to XHTML5 and generates one or more result documents
                from each one.
            </xd:p>
        </xd:desc>
    </xd:doc>
    
    <xd:doc>
        <xd:desc>xsl:key to provide quicker, cleaner access to mentions of people. Use for 
            example like this, to find mentions of a person:
            select="$teiDocs/key('mentionsOfPeople', 'CART2')"
            </xd:desc>
    </xd:doc>
    <xsl:key name="mentionsOfPeople" match="persName[@ref]" use="substring-after(@ref, 'pers:')"/>
    
    <xd:doc>
        <xd:desc>The base template, allDocs, finds all the XML files and processes
        them as required to produce output in XHTML5.</xd:desc>
    </xd:doc>
    <xsl:template name="allDocs">
        
        <xsl:sequence select="hcmc:message(concat('Processing documents in ', $projectData))"/>
        <xsl:sequence select="hcmc:message(concat('Found ', count($teiDocs), ' candidate documents.'))"/>
        
        <xsl:for-each select="$teiDocs/TEI">
            <xsl:variable name="currId" select="@xml:id" as="xs:string"/>
            <xsl:sequence select="hcmc:message($currId)"/>
            <xsl:result-document href="{concat($outputFolder, '/', $currId, '.html')}">
                <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;
            </xsl:text>
                <html lang="en" xmlns="http://www.w3.org/1999/xhtml" id="{$currId}">
                    <xsl:apply-templates select=".">
                        <xsl:with-param name="currId" select="$currId" as="xs:string" tunnel="yes"/>
                    </xsl:apply-templates>
                </html>
            </xsl:result-document>
        </xsl:for-each>
        
        <xsl:sequence select="hcmc:message('Done.')"/>
        <xsl:call-template name="createDocIndex"/>
        
    </xsl:template>
    
    <xd:doc scope="component">
        <xd:desc>This template creates a nested set of indexes enabling users to browse the 
                 document collection.</xd:desc>
    </xd:doc>
    <xsl:template name="createDocIndex">
<!--    First we create an index of the core documents (personography, bibliography and 
        sub-indexes).
        -->
        <xsl:result-document href="{concat($outputFolder, '/contents.html')}">
            <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;
            </xsl:text>
            <html lang="en" xmlns="http://www.w3.org/1999/xhtml" id="index">
                <head>
                    <title><xsl:value-of select="$projectTitlePlain"/>: <xsl:value-of select="$docIndexTitlePlain"/></title>
                    
                    <xsl:sequence select="$linkedResources"/>
                </head>
                
                <body>
                    <xsl:call-template name="header"/>
                    <xsl:call-template name="nav"/>
                    
                    <div class="body">
                        
                        <h2><xsl:sequence select="$docIndexTitle"/></h2>
                        
                        <ul>
                            <li><a href="map.html">Map</a></li>
                            <xsl:for-each-group select="$teiDocs/TEI[not(@xml:id = ('personography', 'bibliography', 'placeography'))]" group-by="//titleStmt/title/name[@type='legislature']/@ref">
                                <xsl:sort select="hcmc:getTaxonomyVal(current-grouping-key())"/>
                                <li>
                                    <a href="{substring-after(current-grouping-key(), 'lg:')}.html">
                                        <xsl:sequence select="hcmc:getTaxonomyVal(current-grouping-key())"/>
                                    </a>
                                </li>
                            
                            </xsl:for-each-group>          
                            
                            <li><a href="bibliography.html"><xsl:apply-templates select="$teiDocs/TEI[@xml:id='bibliography']//titleStmt/title[1]"/></a></li>
                            <li><a href="personography.html"><xsl:apply-templates select="$teiDocs/TEI[@xml:id='personography']//titleStmt/title[1]"/></a></li>
                            <li><a href="placeography.html"><xsl:apply-templates select="$teiDocs/TEI[@xml:id='placeography']//titleStmt/title[1]"/></a></li>
<!--                           Ad-hoc additions that will be removed eventually. -->
                            <li><a href="unidentified_names.htm">Unidentified names</a> needing research</li>
                            <li><a href="a_to_z.htm">Project A to Z</a> of all items with ids</li>
                        </ul>
                        
                    </div>
                    <xsl:call-template name="footer"/>
                </body>
            </html>
        </xsl:result-document>
        
<!--   Next, we create the index pages for each of the individual legislatures.     -->
        <xsl:for-each-group select="$teiDocs/TEI[not(@xml:id = ('personography', 'bibliography'))]" group-by="//titleStmt/title/name[@type='legislature']/@ref">
            <xsl:variable name="leg" select="current-grouping-key()"/>
            <xsl:variable name="legTitle" select="hcmc:getTaxonomyVal(current-grouping-key())"/>
            <xsl:result-document href="{concat($outputFolder, '/', substring-after($leg, 'lg:'))}.html">
                <html lang="en" xmlns="http://www.w3.org/1999/xhtml" id="index_{$leg}">
                    <head>
                        <title><xsl:value-of select="$docIndexTitle"/>: <xsl:value-of select="$legTitle"/></title>
                        
                        <xsl:sequence select="$linkedResources"/>
                    </head>
                    
                    <body>
                        <xsl:call-template name="header"/>
                        <xsl:call-template name="nav"/>
                        
                        <div class="body">
                            
                            <h2><xsl:sequence select="$docIndexTitle"/>: <xsl:value-of select="$legTitle"/></h2>
                            
                            <ul>
                                <xsl:for-each select="$teiDocs/TEI[//titleStmt/title/name[@type='legislature']/@ref = $leg]">
                                    <xsl:sort select="tokenize(@xml:id, '_')[last()]"/>
                                    <li>
                                        <a href="{@xml:id}.html">
                                            <xsl:apply-templates select="//titleStmt/title[1]"/>
                                        </a>
                                    </li>
                                </xsl:for-each>          
                            </ul>
                            
                        </div>
                        <xsl:call-template name="footer"/>
                    </body>
                </html>
            </xsl:result-document>
            
        </xsl:for-each-group>
        
    </xsl:template>

    
</xsl:stylesheet>
