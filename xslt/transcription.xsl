<?xml version="1.0" encoding="UTF-8" ?>
<!-- Last update 2018-04-09 by Alex May-->
<!-- Namespace: think of this as  way to disambiguate terms  the key element you need is the xpath-default-namespace -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xhtml="http://www.w3.org/1999/xhtml"
    xmlns="http://www.w3.org/1999/xhtml" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <!-- Output as xhtml -->
    <xsl:output method="xhtml" doctype-public="-//W3C/DTD XHTML 1.0 STRICT//EN"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" encoding="UTF-8"
        indent="yes"/>
    <!-- A variable which is our directory path (relative to the output document) to the
        directory containing the thumb and full size JPEG document images.
    -->
    <xsl:variable name="thumbnail-dir">images/thumb</xsl:variable>
    <xsl:variable name="jpeg-dir">images</xsl:variable>
    <!-- A variable for inline notes in which we set its initial value at 0.
    -->
    <xsl:variable name="inline-notes">0</xsl:variable>
    <!-- Variables for counting.
    -->
    <xsl:variable name="expan" select="count(//expan)"/>
    <xsl:variable name="place" select="count(//div[@type = 'edition']/ab/placeName)"/>
    <xsl:variable name="people" select="count(//div[@type = 'edition']/ab/persName)"/>
    <xsl:variable name="word" select="count(//div[@type = 'edition']/ab//w)"/>
    <xsl:variable name="nominative" select="count(//div[@type = 'edition']/ab//w[contains(@ana, 'Nominative')])"/>
    <xsl:variable name="genitive" select="count(//div[@type = 'edition']/ab//w[contains(@ana, 'Genitive')])"/>
    <xsl:variable name="dative" select="count(//div[@type = 'edition']/ab//w[contains(@ana, 'Dative')])"/>
    <xsl:variable name="accusative" select="count(//div[@type = 'edition']/ab//w[contains(@ana, 'Accusative')])"/>
    <xsl:variable name="ablative" select="count(//div[@type = 'edition']/ab//w[contains(@ana, 'Ablative')])"/>
    <!-- This template writes the entire document into an HTML page -->
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <xsl:value-of select=".//title"/>
                </title>
                <!-- CSS for our web page -->
                <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
                <link rel="stylesheet" type="text/css" href="miscellany.css"/>
            </head>
            <body id="gloss">
                <div id="wrapper">
                    <div id="content_wrapper">
                        <div id="header">
                            <div id="mainnav">
                                <ul>
                                    <li class="bibliographic">
                                        <a href="bibliography.html">Bibliography</a>
                                    </li>
                                    <li class="translation">
                                        <a href="translation.html">Translation</a>
                                    </li>
                                    <li class="gloss">
                                        <a href="#">Transcription</a>
                                    </li>
                                    <li class="about">
                                        <a href="about.html">About</a>
                                    </li>
                                </ul>
                            </div>
                            <h4 style="text-align:left;margin-top:-70px;margin-left:8em;">Latin
                                Epigraphy</h4>
                        </div>
                        <div id="content_main">
                            <xsl:apply-templates/>
                        </div>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
    <!-- Match our root element -->
    <xsl:template match="TEI">
        <xsl:apply-templates select="teiHeader"/>
        <!-- This apply-template writes the image facsimile into the document, after the header. -->
        <xsl:apply-templates select="facsimile"/>
        <!-- This apply-template writes the text itself into the document, after the facsimile. -->
        <xsl:apply-templates select="//text"/>
        <!-- This apply-template creates notes. -->
        <xsl:if test="$inline-notes = 0">
            <hr/>
            <b>Notes</b>
            <xsl:apply-templates select="//div[@type = 'edition']//note" mode="endnote"/>
        </xsl:if>
    </xsl:template>
    <!-- Suppress from view these tei elements for project editing -->
    <xsl:template match="fileDesc/publicationStmt"/>
    <xsl:template match="fileDesc/sourceDesc/msDesc/msIdentifier"/>
    <xsl:template match="fileDesc/sourceDesc/msDesc/msContents/textLang"/>
    <xsl:template match="fileDesc/sourceDesc/msDesc/physDesc/handDesc"/>
    <xsl:template match="fileDesc/sourceDesc/msDesc/physDesc/decoDesc"/>
    <xsl:template match="fileDesc/sourceDesc/msDesc/history/provenance"/>
    <xsl:template match="fileDesc/sourceDesc/listBibl"/>
    <xsl:template match="encodingDesc"/>
    <xsl:template match="profileDesc"/>
    <xsl:template match="revisionDesc"/>
    <xsl:template match="body/div[@type = 'bibliography']"/>
    <xsl:template match="//msDesc"/>
    <xsl:template match="//sourceDesc"/>
    <xsl:template match="body/div[@type = 'apparatus']"/>
    <xsl:template match="body/div[@type = 'commentary']"/>
    <xsl:template match="body/div[@type = 'translation']"/>
    <!-- Display these tei elements -->
    <xsl:template match="//title">
        <h3 class="center">
            <i>
                <xsl:apply-templates/>
            </i>
        </h3>
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
    <!-- Body -->
    <xsl:template match="//body">
        <xsl:apply-templates/>
    </xsl:template>
    <!-- Div  -->
    <xsl:template match="./div[@type = 'edition']">
        <b>Transcription: </b>
        <xsl:apply-templates/>
        <br/>
        <b>What these colors mean:</b>
        <br/>
        <br/>
        <p style="color:#BDBDBD">(This is supplied text)</p>
        <p style="color:#FF8000">This is a place name</p>
        <p style="color:#2E9AFE">This is a personal name</p>
        <p style="color:#CD853F;">This is a corporate entity, like a legion or office</p>
        <br/>
        <b>Morphographical Analysis: </b>
        <br/>
        <br/>
        <p>There are <xsl:value-of select="$word"/> words, or word like phrases.</p>
        <p>The nominative is used: <xsl:value-of select="$nominative"/> times.</p>
        <p>The genitive is used: <xsl:value-of select="$genitive"/> times.</p>
        <p>The dative is used: <xsl:value-of select="$dative"/> times.</p>
        <p>The accusative is used: <xsl:value-of select="$accusative"/> times.</p>
        <p>The ablative is used: <xsl:value-of select="$ablative"/> times.</p>
        <br/>
        <b>Contextual Analysis:</b>
        <br/>
        <br/>
        <p>This artificat mentions <xsl:value-of select="$place"/> places and <xsl:value-of
                select="$people"/> people.</p>
        <br/>
    </xsl:template>
    <!-- P and AB -->
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
    <!-- LINE BEGININGS -->
    <xsl:template match="lb[@n]">
        <br/>
        <span style="color: black">[Line <xsl:value-of select="@n"/>]</span>
        <span class="left">
            <xsl:value-of select="lb"/>
        </span>
    </xsl:template>
    <!-- COLORIZE SOME CONTENT -->
    <!--orgName-->
    <xsl:template match="orgName">
        <span style="color:#CD853F;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <!--placeName-->
    <xsl:template match="placeName">
        <span style="color: #ff8000;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <!--persName-->
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
    <!-- EDITORIAL INTERVENTIONS -->
    <xsl:template match="supplied">
        <span style="color: #bdbdbd;">[<xsl:apply-templates/>] </span>
    </xsl:template>
    <xsl:template match="ex">
        <span style="color: #bdbdbd;">(<xsl:apply-templates/>) </span>
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
    <!-- LINKS -->
    <!--orgName-->
    <xsl:template match="//orgName[@ref]">
        <a style="color:#CD853F; 
            text-decoration:none;">
            <xsl:attribute name="href">
                <xsl:value-of select="@ref"/>
            </xsl:attribute>
            <xsl:attribute name="target"> _blank </xsl:attribute>
            <xsl:apply-templates/>
        </a>
    </xsl:template>
    <!--placeName-->
    <xsl:template match="//placeName[@ref]">
        <a style="color: #FF8000; 
            text-decoration:none; ">
            <xsl:attribute name="href">
                <xsl:value-of select="@ref"/>
            </xsl:attribute>
            <xsl:attribute name="target"> _blank </xsl:attribute>
            <xsl:apply-templates/>
        </a>
    </xsl:template>
    <!--persName-->
    <xsl:template match="//persName[@ref]">
        <a style="color: #2E9AFE; 
            text-decoration:none;">
            <xsl:attribute name="href">
                <xsl:value-of select="@ref"/>
            </xsl:attribute>
            <xsl:attribute name="target"> _blank </xsl:attribute>
            <xsl:apply-templates/>
        </a>
    </xsl:template>
    <!--lemma and lemmaRef-->
    <xsl:template match=".//w[@lemma]">
        <span class="tooltip">
            <xsl:choose>
                <xsl:when test="@lemmaRef">
                    <a>
                        <xsl:attribute name="href">
                            <xsl:value-of select="@lemmaRef"/>
                        </xsl:attribute>
                        <xsl:attribute name="target"> _blank </xsl:attribute>
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
    <!--all other links-->
    <xsl:template match="//ref[@target]">
        <a class="bibLink">
            <xsl:attribute name="href">
                <xsl:value-of select="@target"/>
            </xsl:attribute>
            <xsl:attribute name="target"> _blank </xsl:attribute>
            <xsl:apply-templates/>
        </a>
    </xsl:template>
</xsl:stylesheet>
