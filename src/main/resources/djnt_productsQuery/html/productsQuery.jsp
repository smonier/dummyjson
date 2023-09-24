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

<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>

<jcr:nodeProperty node="${currentNode}" name="jcr:title" var="title"/>
<jcr:nodeProperty node="${currentNode}" name="bannerText" var="bannerText"/>
<jcr:nodeProperty node="${currentNode}" name="category" var="category"/>




<p class="card-text text-secondary">${bannerText}</p>

<c:choose>
    <c:when test="${category == 'none'}">
        <c:set var="products" value="${dj:fetchProducts()}"/>
    </c:when>
    <c:otherwise>
        <c:set var="products" value="${dj:fetchProductsByCategory(category)}"/>    </c:otherwise>
</c:choose>

<div class="container">
    <div class="row">
        <c:forEach var="product" items="${products}">
            <div class="col-md-4">
                <div class="card" style="width: 18rem;">
                    <img src="${product.getThumbnail()}" class="card-img-top" alt="${product.title}">
                    <div class="card-body">
                        <h5 class="card-title">${product.getTitle()}</h5>
                        <p class="card-text">${product.getDescription()}</p>
<!--                      <p class="card-text">Price: ${product.price}</p>
                        <p class="card-text">Stock: ${product.stock}</p>
                        <p class="card-text">Brand: ${product.brand}</p>
                        <p class="card-text">Category: ${product.category}</p>
                        <p class="card-text">Rating: ${product.rating}</p>
                        <p class="card-text">Discount: ${product.discountPercentage}%</p>>--> 
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>