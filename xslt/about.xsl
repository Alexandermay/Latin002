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
            <body id="about">
                <div id="wrapper">
                    <div id="content_wrapper">
                        <div id="header">
                            <!--This starts the header for the web page-->
                            <div id="mainnav">
                                <ul>
                                    <li class="bibliographic">
                                        <a href="bibliography.html">Bibliography</a>
                                        <li class="translation">
                                            <a href="translation.html">Translation</a>
                                        </li>
                                    </li>
                                    <li class="gloss">
                                        <a href="HD033176.html">Transcription</a>
                                    </li>
                                    <li class="about">
                                        <a href="#">About</a>
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
        <!-- This apply-template writes the teiHeader into the top of the document -->
        <xsl:apply-templates select="//fileDesc/titleStmt/title"/>
        <!-- This apply-template writes the image facsimile into the document, after the header. -->
        <xsl:apply-templates select="facsimile"/>
        <!-- This apply-template writes the teiHeader into the top of the document -->
        <xsl:apply-templates select="*//sourceDesc"/>
        <xsl:apply-templates select="/TEI/text/body/div[@type = 'commentary']"/>
        <xsl:if test="$inline-notes = 0">
            <hr/>
            <b>Notes</b>
            <xsl:apply-templates select="//div[@type = 'commentary']//note" mode="endnote"/>
        </xsl:if>
    </xsl:template>
    <!-- Suppress from view these tei elements for project editing -->
    <xsl:template match="tei:fileDesc/tei:publicationStmt"/>
    <xsl:template match="tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msIdentifier"/>
    <xsl:template match="tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msContents/tei:textLang"/>
    <xsl:template match="tei:fileDesc/tei:sourceDesc/tei:listBibl"/>
    <xsl:template match="tei:encodingDesc"/>
    <xsl:template match="tei:revisionDesc"/>
    <xsl:template match="//body"/>
    <xsl:template match="tei:body/tei:div[@type = 'bibliography']"/>
    <!-- Display these tei elements -->
    <xsl:template match="//title">
        <h3 class="center">
            <i>
                <xsl:apply-templates/>
            </i>
        </h3>
    </xsl:template>
    <xsl:template match="//msItem">
        <p>
            <b>Contents: </b>
            <br/>
            <br/>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="//support/p">
        <p>
            <b>Summary of Support: </b>
            <br/>
            <br/>
            <xsl:apply-templates/>
        </p>
        <br/>
    </xsl:template>
    <xsl:template match="//objectDesc/supportDesc/support/dimensions/height">
        <p><b>Height: </b><xsl:apply-templates/> cm</p>
    </xsl:template>

    <xsl:template match="//objectDesc/supportDesc/support/dimensions/width">
        <p><b>Width: </b><xsl:apply-templates/> cm</p>
    </xsl:template>

    <xsl:template match="//objectDesc/supportDesc/support/dimensions/depth">
        <p><b>Depth: </b><xsl:apply-templates/> cm</p>
        <br/>
    </xsl:template>

    <xsl:template match="//supportDesc/condition/p">
        <p>
            <b>Condition: </b>
            <xsl:apply-templates/>
        </p>
        <br/>
    </xsl:template>

    <xsl:template match="//layoutDesc/layout/p">
        <p>
            <b>Layout: </b>
            <xsl:apply-templates/>
        </p>
        <br/>
    </xsl:template>

    <xsl:template match="//physDesc/handDesc">
        <p>
            <b>Letter style: </b>
            <xsl:apply-templates/>
        </p>
        <br/>
    </xsl:template>

    <xsl:template match="//physDesc/handDesc/handNote/height">
        <p>
            <b>Letter height: </b>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="//history/origin/origDate">
        <b>Date: </b>
        <xsl:apply-templates/>
        <br/>
    </xsl:template>

    <xsl:template match="//history/origin/origPlace">
        <b>Place Created: </b>
        <xsl:apply-templates/>
        <br/>
    </xsl:template>

    <xsl:template match="//history/provenance[@type='found']">
        <b>Place Found: </b>
        <xsl:apply-templates/>
        <br/>
    </xsl:template>
    <xsl:template match="//history/provenance[@type='repository']">
        <b>Currently housed: </b>
        <xsl:apply-templates/>
        <br/>
        <br/>
    </xsl:template>

    <xsl:template match="//body/div[@type = 'commentary']">
        <b>Commentary: </b>
        <br/>
        <br/>
        <xsl:apply-templates/>
        <br/>
        <br/>
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


    <!-- P and AB -->

    <xsl:template match="p">
        <p>
            <xsl:apply-templates/>        
        </p>
        <br/>
    </xsl:template>
    <xsl:template match="ab">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <!-- LINE BEGININGS -->

    <xsl:template match="lb[@n]">
        <br/>
        <span style="color: black">[Line <xsl:value-of select="@n"/>]</span>
        <span class="left">
            <xsl:value-of select="lb"/>
        </span>
    </xsl:template>

    <!-- TRANSCRIPTION -->

    <xsl:template match="orgName">
        <span style="color:#CD853F;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="placeName">
        <span style="color: #ff8000;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="persName">
        <span style="color: #2E9AFE;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!-- FORM AND APPEARANCE -->

    <xsl:template match="g[@type = 'interpunct']"> &#183; </xsl:template>
    <xsl:template match="hi[@rend = 'apex']"> &#769;<xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="emph">
        <em>
            <xsl:apply-templates/>
        </em>
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
    <!-- Annotations -->  
    <xsl:template match="note">
        <xsl:choose>
            <xsl:when test="$inline-notes">
                <sup>
                    <xsl:value-of select="index-of(//note, .)"/>
                </sup>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="//note" mode="endnote">
        <p>
            <xsl:value-of select="index-of(//note, .)"/>.&#160;&#160; <xsl:apply-templates/>
        </p>
    </xsl:template>  
</xsl:stylesheet>
