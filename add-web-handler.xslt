<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
	<xsl:variable name="handler" select="/Root/add"/>
    <xsl:output method="xml" indent="yes"/>
	
	<xsl:template match="Root" >
		<xsl:apply-templates select="configuration"/>
	</xsl:template>
	
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

	<xsl:template match="system.webServer">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
			<xsl:if test="not(handlers)">
				<handlers>
					<xsl:copy-of select="$handler"/>	
				</handlers>
			</xsl:if>		
		</xsl:copy>
	</xsl:template>

	<xsl:template match="handlers">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
			<xsl:if test="not(add[@name=$handler/@name])">
				<xsl:copy-of select="$handler"/>
			</xsl:if>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
