<xsl:stylesheet xmlns:xsl = "http://www.w3.org/1999/XSL/Transform" version = "1.0" >
<xsl:output method="text" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" indent="yes" encoding="UTF-8" />
<xsl:template match = "/icestats" >
---
<xsl:for-each select="source">
<xsl:value-of select="@mount" />:
    server_name: <xsl:value-of select="server_name" />
    server_type: <xsl:value-of select="server_type" />
    server_url: <xsl:value-of select="server_url" />
    server_description: <xsl:value-of select="server_description" />
    listeners: <xsl:value-of select="listeners" />
    artist: <xsl:value-of select="artist" />
    title: <xsl:choose> <xsl:when test="starts-with(title,' -')" ><xsl:value-of select="substring-after(title,'-')" /></xsl:when><xsl:otherwise><xsl:value-of select="title" /></xsl:otherwise></xsl:choose>
    listenurl: <xsl:value-of select="listenurl" />

<xsl:text>
</xsl:text>
</xsl:for-each>
</xsl:template>
</xsl:stylesheet>

