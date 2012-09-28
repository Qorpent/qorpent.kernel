<?xml version="1.0" encoding="utf-8"?>
<!--
Copyright 2007-2012 Comdiv (F. Sadykov) - http://code.google.com/u/fagim.sadykov/
Supported by Media Technology LTD 
 
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
 
http://www.apache.org/licenses/LICENSE-2.0
 
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
	<!-- XSL used by community Xslt TASK to embed handlers/add element into existed web.config -->
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
