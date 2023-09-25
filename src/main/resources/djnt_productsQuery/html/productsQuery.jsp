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
<jcr:nodeProperty node="${currentNode}" name="category" var="category"/>


<c:set var="rand">
    <%= java.lang.Math.round(java.lang.Math.random() * 10000) %>
</c:set>
<c:set var="carouselId" value="carousel-${rand}"/>


<c:choose>
    <c:when test="${category == 'none'}">
        <c:set var="products" value="${dj:fetchProducts()}"/>
    </c:when>
    <c:otherwise>
        <c:set var="products" value="${dj:fetchProductsByCategory(category)}"/>
    </c:otherwise>
</c:choose>


<div class="container-xl">
    <div class="row">
        <div class="col-md-12">
            <h2><b>${bannerText}</b></h2>
            <div class="owl-carousel owl-theme owl-drag animated carousel" id="${carouselId}">
                    <c:forEach var="product" items="${products}" varStatus="status">
                            <div class="item px-2">
                                <div class="thumb-wrapper">
                                    <span class="wish-icon"><i class="fa fa-heart-o"></i></span>
                                    <div class="img-box">
                                        <img src="${product.getThumbnail()}" class="img-fluid" alt="">
                                    </div>
                                    <div class="thumb-content">
                                        <h5>${product.getTitle()}</h5>
                                        <p>${product.getDescription()}</p>
                                        <div class="star-rating">
                                            <ul class="list-inline">
                                                <span style="--rating:${product.getRating()}"></span>
                                            </ul>
                                        </div>
                                        <p class="item-price"><b>${product.getBrand()}</b></p>
                                        <p class="item-price"><b>€ ${product.getPrice()}</b></p>
                                        <a href="#" class="btn btn-primary">Add to Cart</a>
                                    </div>
                                </div>
                            </div>
                    </c:forEach>
            </div>
        </div>
    </div>
</div>

<script>
    $('#${carouselId}').owlCarousel({
        autoplay: true,
        rewind: true, /* use rewind if you don't want loop */
        margin: 20,
        /*
       animateOut: 'fadeOut',
       animateIn: 'fadeIn',
       */
        responsiveClass: true,
        autoHeight: true,
        autoplayTimeout: 7000,
        smartSpeed: 800,
        nav: true,
        navText: ['<span class="ion-ios-arrow-back">', '<span class="ion-ios-arrow-forward">'],
        responsive: {
            0: {
                items: 1
            },

            600: {
                items: 3
            },

            1024: {
                items: 4
            },

            1366: {
                items: 4
            }
        }
    });
</script>