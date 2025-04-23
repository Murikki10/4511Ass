<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List,it.ass.model.Fruit,it.ass.model.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    List<Fruit> fruitList = (List<Fruit>)request.getAttribute("fruitList");
    List<User> shopsInOtherCities = (List<User>)request.getAttribute("shopsInOtherCities");
%>
<html>
<head>
    <title>新增借水果申請</title>
</head>
<body>
<h2>新增借水果申請</h2>

<c:if test="${not empty error}">
    <p style="color:red;">${error}</p>
</c:if>

<form method="post" action="${pageContext.request.contextPath}/borrow/add">
    <label for="fromShopId">借出店鋪：</label>
    <select name="fromShopId" id="fromShopId" required>
        <option value="">--請選擇借出店鋪--</option>
        <c:forEach items="${shopsInOtherCities}" var="shop">
            <option value="${shop.shopId}" <c:if test="${param.fromShopId == shop.shopId}">selected</c:if>>
                <c:out value="${shop.username}" /> (城市：<c:out value="${shop.city}" />)
            </option>
        </c:forEach>
    </select>
    <br/><br/>

    <label for="fruitId">水果：</label>
    <select name="fruitId" id="fruitId" required>
        <option value="">--請選擇水果--</option>
        <c:forEach items="${fruitList}" var="fruit">
            <option value="${fruit.fruitId}" <c:if test="${param.fruitId == fruit.fruitId}">selected</c:if>>
                <c:out value="${fruit.name}" /> (來源：<c:out value="${fruit.sourceCountry}" />)
            </option>
        </c:forEach>
    </select>
    <br/><br/>

    <label for="quantity">數量：</label>
    <input type="number" name="quantity" id="quantity" min="1" required value="${param.quantity != null ? param.quantity : ''}" />
    <br/><br/>

    <button type="submit">申請借用</button>
</form>

<br/>
<a href="${pageContext.request.contextPath}/borrow/list">回借用紀錄</a>
</body>
</html>