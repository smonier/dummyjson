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
<%@ taglib prefix="dj" uri="http://www.jahia.org/tags/dummyjson" %>
<%@ taglib prefix="fa" uri="http://font-awesome.com/taglibs" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.NumberFormat" %>

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

<jcr:nodeProperty node="${currentNode}" name="jcr:title" var="title"/>
<jcr:nodeProperty node="${currentNode}" name="bannerText" var="bannerText"/>
<jcr:nodeProperty node="${currentNode}" name="dj:category" var="category"/>
<jcr:nodeProperty node="${currentNode}" name="buttonLabel" var="buttonLabel"/>
<jcr:nodeProperty node="${currentNode}" name="dj:mocksSource" var="mockSource"/>
<jcr:nodeProperty node="${currentNode}" name="dj:products" var="customCode"/>
<jcr:nodeProperty node="${currentNode}" name="dj:url" var="jsonUrl"/>


<c:if test="${jcr:isNodeType(currentNode, 'djmix:owlcarouselAdvancedSettings')}">
    <c:set var="options" value="${currentNode.properties.options.string}"/>
    <c:set var="class" value="${currentNode.properties.class.string}"/>
</c:if>


<c:set var="rand">
    <%= java.lang.Math.round(java.lang.Math.random() * 10000) %>
</c:set>
<c:set var="carouselId" value="carousel-${rand}"/>


<c:choose>
    <c:when test="${mockSource == 'direct'}">
        <c:set var="products" value="${dj:processCustomCode(customCode)}"/>
    </c:when>
    <c:when test="${mockSource == 'reference'}">
        <c:choose>
            <c:when test="${category == 'none'}">
                <c:set var="products" value="${dj:fetchProducts()}"/>
            </c:when>
            <c:otherwise>
                <c:set var="products" value="${dj:fetchProductsByCategory(category)}"/>
            </c:otherwise>
        </c:choose>
    </c:when>
    <c:when test="${mockSource == 'url'}">
        <c:set var="products" value="${dj:processUrl(jsonUrl)}"/>
    </c:when>
    <c:otherwise>
        <c:set var="products" value="${dj:fetchRawProducts()}"/>
    </c:otherwise>
</c:choose>


<div class="container-xl dj">
    <div class="row">
        <div class="col-md-12">
            <h2><b>${bannerText}</b></h2>
            <div class="owl-carousel owl-theme owl-drag animated dj-carousel" id="${carouselId}">
                <c:forEach var="product" items="${products}" varStatus="status">
                    <div class="item px-2">
                        <div class="thumb-wrapper">
                            <span class="wish-icon"><i class="fa fa-heart-o"></i></span>
                            <div class="img-box">
                                <img src="${product.getThumbnail()}" class="img-fluid" alt="">
                            </div>
                            <div class="thumb-content">
                                <h5>${product.getTitle()}</h5>
                                <span class="category">${product.getCategory()}</span>
                                <p>${product.getDescription()}</p>
                                <div class="star-rating">
                                    <ul class="list-inline">
                                        <span style="--rating:${product.getRating()}"></span>
                                    </ul>
                                </div>
                                <p class="item-price"><b>${product.getBrand()}</b></p>
                                <c:choose>
                                    <c:when test="${product.getDiscountPercentage() > 0}">
                                        <fmt:formatNumber
                                                value="${product.getPrice() - ((product.getDiscountPercentage() / 100.0) * product.getPrice())}"
                                                type="number" pattern="#.##" var="roundedNumber"/>
                                        <p class="item-price"><strike>${product.getPrice()}</strike>
                                            <b>EUR ${roundedNumber}</b></p>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="item-price"><b>EUR ${product.getPrice()}</b></p>
                                    </c:otherwise>
                                </c:choose>

                                <a href="#" class="btn btn-primary">${buttonLabel}</a>
                            </div>
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
