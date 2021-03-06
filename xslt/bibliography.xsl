<?xml version="1.0" encoding="UTF-8" ?>
<!-- Last update 2018-04-09 by Alex May-->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xhtml="http://www.w3.org/1999/xhtml"
    xmlns="http://www.w3.org/1999/xhtml" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <xsl:output method="xhtml" doctype-public="-//W3C/DTD XHTML 1.0 STRICT//EN"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" encoding="UTF-8"
        indent="yes"/>
    <!-- A variable which is our directory path (relative to the output document) to the
        directory containing full size JPEG document images.
    -->
    <xsl:variable name="thumbnail-dir">images/thumb</xsl:variable>
    <xsl:variable name="jpeg-dir">images</xsl:variable>
    <!-- A variable for inline notes in which we set its initial value at 0.
    -->
    <xsl:variable name="inline-notes">0</xsl:variable>
    <!-- This template writes the entire document into an HTML page -->
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <xsl:value-of select="//title"/>
                </title>
                <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
                <link rel="stylesheet" type="text/css" href="miscellany.css"/>
            </head>
            <body id="bibliographic">
                <div id="wrapper">
                    <div id="content_wrapper">
                        <div id="header">
                            <div id="mainnav">
                                <ul>
                                    <li class="bibliographic">
                                        <a href="#">Bibliography</a>
                                    </li>
                                    <li class="translation">
                                        <a href="translation.html">Translation</a>
                                    </li>
                                    <li class="gloss">
                                        <a href="HD033176.html">Transcription</a>
                                    </li>
                                    <li class="about">
                                        <a href="about.html">About</a>
                                    </li>
                                </ul>
                            </div>
                            <h4 style="text-align:left;margin-top:-70px;margin-left:8em;">Latin Epigraphy</h4>
                        </div>
                        <div id="content_main">
                            <xsl:apply-templates select="TEI"/>
                        </div>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
    <!-- Match our root element -->
    <xsl:template match="TEI">
        <xsl:apply-templates/>
    </xsl:template>
    <!-- Suppress from view these tei elements for project editing -->
    <xsl:template match="tei:fileDesc/tei:publicationStmt"/>
    <xsl:template match="tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msIdentifier"/>
    <xsl:template match="tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msContents/tei:textLang"/>
    <xsl:template match="tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:physDesc/tei:handDesc"/>
    <xsl:template match="tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:physDesc/tei:decoDesc"/>
    <xsl:template match="tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:history/tei:provenance"/>
    <xsl:template match="tei:fileDesc/tei:sourceDesc/tei:listBibl"/>
    <xsl:template match="tei:encodingDesc"/>
    <xsl:template match="tei:profileDesc"/>
    <xsl:template match="tei:revisionDesc"/>
    <xsl:template match="//msDesc"/>
    <xsl:template match="//history"/>
    <xsl:template match="./div[@type = 'edition']"/>
    <xsl:template match="//body/div[@type = 'commentary']"/>
    <xsl:template match="//body/div[@type = 'translation']"/>
    <xsl:template match="//body/div[@type = 'apparatus']"/>
    <xsl:template match="note"/>
    <!-- Display these tei elements -->
    <xsl:template match="//title">
        <h3 class="center">
            <i>
                <xsl:apply-templates/>
            </i>
        </h3>
    </xsl:template>
    <xsl:template match="//body/div[@type = 'bibliography']">
        <b>Bibliography: </b>
        <br/>
        <br/>
        <xsl:apply-templates/>
    </xsl:template>
    <!-- Format the bibliography -->
    <xsl:template match="bibl">
        <ul>
            <li><xsl:apply-templates/></li>
        </ul>
    </xsl:template>
    <xsl:template match="p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="ab">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <!-- facsimile display -->
    <xsl:template match="//facsimile">
        <p class="center">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="//graphic">
        <span>
            <a class="demo" href="{$jpeg-dir}/{@url}.jpg">
                <img src="{$thumbnail-dir}/{@url}.jpg" class="shrinktofit"/>
            </a>
        </span>
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"/>
        <script type="text/javascript" src="jquery/jquery.loupe.min.js"/>
        <script type="text/javascript">$('.demo').loupe();</script>
        <xsl:apply-templates/>
    </xsl:template>    
    <!-- LINKS -->   
    <xsl:template match="//orgName[@ref]">
        <a style="color:#CD853F; 
            text-decoration:none;">
            <xsl:attribute name="href">
                <xsl:value-of select="@ref"/>
            </xsl:attribute>
            <xsl:attribute name="target">
                <xsl:value-of select="@ref"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </a>
    </xsl:template>   
    <xsl:template match="//placeName[@ref]">
        <a style="color: #FF8000; 
            text-decoration:none; ">
            <xsl:attribute name="href">
                <xsl:value-of select="@ref"/>
            </xsl:attribute>
            <xsl:attribute name="target">
                <xsl:value-of select="@ref"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </a>
    </xsl:template>   
    <xsl:template match="//persName[@ref]">
        <a style="color: #2E9AFE; 
            text-decoration:none;">
            <xsl:attribute name="href">
                <xsl:value-of select="@ref"/>
            </xsl:attribute>
            <xsl:attribute name="target">
                <xsl:value-of select="@ref"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </a>
    </xsl:template>    
    <xsl:template match=".//w[@lemma]">
        <span class="tooltip">
            <xsl:choose>
                <xsl:when test="@lemmaRef">
                    <a>
                        <xsl:attribute name="href">
                            <xsl:value-of select="@lemmaRef"/>
                        </xsl:attribute>
                        <span class="tooltiptext"><xsl:value-of select="@ana"/> form of
                            <xsl:value-of select="@lemma"/></span>
                        <xsl:apply-templates/>
                    </a>
                </xsl:when>
                <xsl:otherwise>
                    <span class="tooltiptext"><xsl:value-of select="@ana"/> form of <xsl:value-of
                        select="@lemma"/></span>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>  
    <xsl:template match="//ref[@target]">
        <a class="bibLink">
            <xsl:attribute name="href">
                <xsl:value-of select="@target"/>
            </xsl:attribute>
            <xsl:attribute name="target">
                <xsl:value-of select="@rend"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </a>
    </xsl:template>
</xsl:stylesheet>
