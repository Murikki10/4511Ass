<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List,it.ass.model.Fruit,it.ass.model.User" %>
<%
    List<Fruit> fruitList = (List<Fruit>)request.getAttribute("fruitList");
    List<User> shopsInCity = (List<User>)request.getAttribute("shopsInCity");
    String error = (String)request.getAttribute("error");
%>
<html>
<head><title>新增借水果申請</title></head>
<body>
<h2>新增借水果申請</h2>
<% if(error != null) { %>
    <p style="color:red;"><%= error %></p>
<% } %>
<form method="post" action="<%=request.getContextPath()%>/borrow/add">
    借出店鋪：
    <select name="fromShopId" required>
        <% for(User shop : shopsInCity) { %>
            <option value="<%= shop.getShopId() %>"><%= shop.getUsername() %> (城市：<%= shop.getCity() %>)</option>
        <% } %>
    </select><br/>
    水果：
    <select name="fruitId" required>
        <% for(Fruit f : fruitList) { %>
            <option value="<%= f.getFruitId() %>"><%= f.getName() %> (來源：<%= f.getSourceCountry() %>)</option>
        <% } %>
    </select><br/>
    數量：<input type="number" name="quantity" min="1" required/><br/>
    <button type="submit">申請借用</button>
</form>
<a href="<%=request.getContextPath()%>/borrow/list">回借用紀錄</a>
</body>
</html>