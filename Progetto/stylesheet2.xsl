<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs">
    
    <xsl:output method="html" />
    <xsl:template match="/"> <!--Si possono fare vari match--> <!--I match si richiamano con apply-template-->
        <html>
            <head>
                <title>
                    <xsl:value-of select="//tei:titleStmt/tei:title"/>
                </title>
                <!-- script src e script type per JS -->
                <style>
                    body {
                    background-color: rgb(255, 192, 182);
                    }
                    
                    h1{
                    font-family: Arial, Helvetica, sans-serif;
                    
                    }
                    h3{
                    font-size: 15px;
                    }
                </style>
            </head>
            <body>
                <div id="intestazione">
                    <h1 style=""><xsl:value-of select="//tei:titleStmt/tei:title"/></h1>
                    <p id="cura">
                        <strong> A cura di: </strong><xsl:value-of select="//tei:titleStmt/tei:respStmt/tei:name[@xml:id='RM']"/>, <xsl:value-of select="//tei:titleStmt/tei:respStmt/tei:name[@xml:id='CM']"/> e <xsl:value-of select="//tei:titleStmt/tei:respStmt/tei:name[@xml:id='EM']"/></p>
                    <p id="compilatore">
                        <strong>Compilatore: </strong> <xsl:value-of select="//tei:editionStmt/tei:respStmt/tei:name[@xml:id='TC']"/>
                    </p>
                    <p id="respScien">
                        <strong>Responsabili scientifici: </strong><xsl:value-of select="//tei:editionStmt/tei:respStmt/tei:name[@xml:id='GP']"/> e <xsl:value-of select="//tei:editionStmt/tei:respStmt/tei:name[@xml:id='ES']"/>
                    </p>
                    <p id="funzResp">
                        <strong>Funzionario responsabile: </strong><xsl:value-of select="//tei:editionStmt/tei:respStmt/tei:name[@xml:id='MR']"/>
                    </p>
                </div>
                <div>
                    <h3 id="info">
                        
                    </h3>
                </div>
                <div id="fronteImg" style="float: left; clear:both; position: relative">
                    <img><xsl:attribute name="src"><xsl:value-of select="//tei:figure/tei:graphic/@url"/></xsl:attribute></img> <!--TOGLIERE PARENTESI QUADRE-->
                    <xsl:for-each select="//tei:surface[@n='1']//tei:zone"> <!-- n=1 è una condizione-->
                        <div class="line">
                            <xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
                            <xsl:attribute name="style"> <xsl:value-of select="@ulx"/> <xsl:value-of select="@uly"/> <xsl:value-of select="(@lry)-(@uly)"/> <xsl:value-of select="((@lrx)-(@ulx))"/> </xsl:attribute> <!-- Determino la distanza dei punti ma non la richiedo-->
                        </div>
                    </xsl:for-each>
                </div>
                <div id="fronteText" style="">
                    <p><xsl:value-of select="//tei:figDesc"/></p>
                    <p class="testo"><xsl:attribute name="id"><xsl:value-of select="//tei:figure//tei:head/@facs"/></xsl:attribute><xsl:value-of select="//tei:figure//tei:head"/></p>
                </div>
                <div>
                    <div id="retroImg" style="float: left; clear:both; position: relative">
                        <img><xsl:attribute name="src"><xsl:value-of select="//tei:surface[@n='2']//tei:graphic/@url"/></xsl:attribute></img>
                        <xsl:for-each select="//tei:surface[@n='2']//tei:zone">
                            <div class="line">
                                <xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
                                <xsl:attribute name="style"> <xsl:value-of select="@ulx"/> <xsl:value-of select="@uly"/> <xsl:value-of select="(@lry)-(@uly)"/> <xsl:value-of select="((@lrx)-(@ulx))"/> </xsl:attribute>
                            </div>
                        </xsl:for-each>
                    </div>
                    <div id="retroText" style="">
                        <div class="left">
                            <h3>Messaggio</h3>
                            <xsl:for-each select="(//tei:div[@type='message']/tei:p)">
                                <p class="testo">
                                    <xsl:attribute name="id"><xsl:value-of select="@facs"/></xsl:attribute>
                                    <xsl:apply-templates/>
                                </p>
                            </xsl:for-each>
                            <p class="testo"><xsl:attribute name="id"><xsl:value-of select="//tei:signed/@facs"/></xsl:attribute><xsl:value-of select="//tei:signed"/>
                            </p>
                        </div> 
                        <div class="right">
                            <h3>Destinazione:</h3>
                            <xsl:for-each select="(//tei:div[@type='destination']//tei:addrLine)">
                                <p class="testo">
                                    <xsl:attribute name="id"><xsl:value-of select="@facs"/></xsl:attribute>
                                    <xsl:apply-templates/>
                                </p>
                            </xsl:for-each>
                        </div>
                        <div class="left">
                            <h3>Timbro e francobollo:</h3> <!--POSTAGE POSTMARK-->
                            <p class="testo">
                                <xsl:attribute name="id"><xsl:value-of select="//tei:div[@type='destination']//tei:stamp[@type='postmark']/@facs"/></xsl:attribute>
                                <xsl:value-of select="//tei:div[@type='destination']//tei:stamp[@type='postage']/@facs"/><!--A cosa serve il facs?--> <!--Forse vanno tole le parentesi quadre-->
                                <xsl:for-each select="(//tei:div[@type='destination']//tei:stamp)">
                                    <xsl:apply-templates/>
                                </xsl:for-each>
                            </p>
                        </div>
                        <div class="right">
                            <h3>Caratteri non manoscritti:</h3>
                            <xsl:for-each select="//tei:div[@type='printed']//tei:p">
                                <p class="testo">
                                    <xsl:attribute name="id"><xsl:value-of select="@facs"/></xsl:attribute>
                                    <xsl:apply-templates/>
                                </p>
                            </xsl:for-each>
                        </div>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>