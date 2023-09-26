<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="query" uri="http://www.jahia.org/tags/queryLib" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="s" uri="http://www.jahia.org/tags/search" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>

<template:addResources type="css" resources="carrousel.css"/>
<template:addResources type="javascript" resources="wish.js"/>
<template:addResources type="css" resources="all.min.css"/>

<%-- Get parameters of the module --%>
<jcr:nodeProperty node="${currentNode}" name='jcr:title' var="title"/>
<jcr:nodeProperty node="${currentNode}" name='startNode' var="startNode"/>
<jcr:nodeProperty node="${currentNode}" name='j:type' var="type"/>
<jcr:nodeProperty node="${currentNode}" name="subNodesView" var="subNodesView"/>
<jcr:nodeProperty node="${currentNode}" name="bannerText" var="bannerText"/>

<c:if test="${jcr:isNodeType(currentNode, 'djmix:owlcarouselAdvancedSettings')}">
    <c:set var="options" value="${currentNode.properties.options.string}"/>
    <c:set var="class" value="${currentNode.properties.class.string}"/>
</c:if>

<c:set var="rand">
    <%= java.lang.Math.round(java.lang.Math.random() * 10000) %>
</c:set>
<c:set var="carouselId" value="carousel-${rand}"/>

<c:set var="targetFolderPath" value="${startNode.node.path}"/>
<jcr:node var="targetNode" path="${targetFolderPath}"/>
<div class="container-xl dj">
    <div class="row">
        <div class="col-md-12">
            <h2><b>${bannerText}</b></h2>
            <div class="owl-carousel owl-drag dj" id="${carouselId}">
                <c:forEach items="${targetNode.nodes}" var="subchild">
                    <div class="item px-1">
                        <div class="thumb-wrapper">
                            <c:if test="${jcr:isNodeType(subchild, type)}">
                                <template:module node="${subchild}" view="${subNodesView}"/>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
<script>
    <%--console.log("options string: ",${options});--%>
    <%--console.log("options out string: ",${not empty options?options:''});--%>
    $('#${carouselId}').owlCarousel(${not empty options?options:''});
</script>