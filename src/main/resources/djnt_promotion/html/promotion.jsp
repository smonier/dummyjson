<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>

<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>

<template:include view="hidden.getLinkToURL"/>
<template:module node="${currentNode.properties['promoImage'].node}" view="hidden.getURL" var="mediaURL"
                 editable="false" templateType="txt">
    <template:param name="width"
                    value="${not empty currentResource.moduleParams.mediaWidth ? currentResource.moduleParams.mediaWidth : '1028'}"/>
    <template:param name="height" value="${currentResource.moduleParams.mediaHeight}"/>
    <template:param name="scale"
                    value="${not empty currentResource.moduleParams.mediaScale ? currentResource.moduleParams.mediaScale : 1}"/>
    <template:param name="quality"
                    value="${not empty currentResource.moduleParams.mediaQuality ? currentResource.moduleParams.mediaQuality : 72}"/>
</template:module>

<a href="${moduleMap.linkUrl}" class="link-thumbnail" target="${moduleMap.linkTarget}">
    <img src="${mediaURL}"
         class="${currentResource.moduleParams.class}"
         alt="${alt}"
    />
</a>