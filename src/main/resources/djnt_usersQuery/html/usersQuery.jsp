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

<%--@elvariable id="currentNode"
type="org.jahia.services.content.JCRNodeWrapper" --%>
<%--@elvariable id="out" type="java.io.PrintWriter" --%>
<%--@elvariable id="script"
type="org.jahia.services.render.scripting.Script"
--%>
<%--@elvariable id="scriptInfo"
type="java.lang.String" --%>
<%--@elvariable id="workspace"
type="java.lang.String" --%>
<%--@elvariable id="renderContext"
type="org.jahia.services.render.RenderContext"
--%>
<%--@elvariable id="currentResource"
type="org.jahia.services.render.Resource"
--%>
<%--@elvariable id="url"
type="org.jahia.services.render.URLGenerator"
--%>
<template:addResources
    type="css"
    resources="users.css" />

<jcr:nodeProperty
    node="${currentNode}"
    name="jcr:title"
    var="title" />
<jcr:nodeProperty
    node="${currentNode}"
    name="bannerText"
    var="bannerText" />
<jcr:nodeProperty
    node="${currentNode}"
    name="dj:category"
    var="category" />
<jcr:nodeProperty
    node="${currentNode}"
    name="buttonLabel"
    var="buttonLabel" />
<jcr:nodeProperty
    node="${currentNode}"
    name="dj:mocksSource"
    var="mockSource" />
<jcr:nodeProperty
    node="${currentNode}"
    name="dj:users"
    var="customCode" />
<jcr:nodeProperty
    node="${currentNode}"
    name="dj:url"
    var="jsonUrl" />


<c:choose>
    <c:when
        test="${mockSource == 'direct'}">
        <c:set var="users"
            value="${dj:processCustomCode(customCode)}" />
    </c:when>
    <c:when
        test="${mockSource == 'reference'}">
        <c:choose>
            <c:when
                test="${category == 'none'}">
                <c:set
                    var="users"
                    value="${dj:getUsersFromUrl(jsonUrl)}" />
            </c:when>
            <c:otherwise>
                <c:set
                    var="users"
                    value="${dj:getUsersFromUrl(jsonUrl)}" />
            </c:otherwise>
        </c:choose>
    </c:when>
    <c:when
        test="${mockSource == 'url'}">
        <c:set var="users"
            value="${dj:getUsersFromUrl(jsonUrl)}" />
    </c:when>
    <c:otherwise>
        <c:set var="users"
            value="${dj:getUsersFromUrl('https://dummyjson.com/users')}" />
    </c:otherwise>
</c:choose>



<div
    class="container profile-page">
    <div class="row">
        <div
            class="col-xl-6 col-lg-7 col-md-12">
            <h2><b>${bannerText}</b>
            </h2>
            <c:forEach
                var="user"
                items="${users}"
                varStatus="status">

                <div
                    class="user-card profile-header">
                    <div
                        class="body">
                        <div
                            class="row">

                            <div
                                class="col-lg-4 col-md-4 col-12">
                                <div
                                    class="profile-image float-md-right">
                                    <c:set var="originalUrl" value="${user.getImage()}" />
                                    <c:set var="newUrl" value="${fn:replace(originalUrl, 'set=set4', 'set=set5')}" />
                                    <img src="${newUrl}"
                                        alt="">
                                </div>
                            </div>
                            <div
                                class="col-lg-8 col-md-8 col-12">
                                <h4
                                    class="m-t-0 m-b-0">
                                    <strong>${user.getFirstName()}</strong>
                                    ${user.getLastName()}
                                </h4>
                                <span
                                    class="job_post">${user.company.getTitle()}</span>
                                <p>${user.company.getDepartment()}
                                </p>
                                <div>
                                    <button
                                        class="btn btn-primary btn-round">${buttonLabel}</button>

                                </div>
                                <p
                                    class="social-icon m-t-5 m-b-0">
                                    <a title="Twitter"
                                        href="javascript:void(0);"><i
                                            class="fa fa-twitter"></i></a>
                                    <a title="Facebook"
                                        href="javascript:void(0);"><i
                                            class="fa fa-facebook"></i></a>
                                    <a title="Linkedin"
                                        href="javascript:void(0);"><i
                                            class="fab fa-linkedin-in"></i></a>
                    
                                    <a title="Instagram"
                                        href="javascript:void(0);"><i
                                            class="fa fa-instagram "></i></a>
                                </p>
                            </div>

                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>