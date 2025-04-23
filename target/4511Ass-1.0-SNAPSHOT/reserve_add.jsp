<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List,it.ass.model.Fruit" %>
<%
    List<Fruit> fruitList = (List<Fruit>)request.getAttribute("fruitList");
    String error = (String)request.getAttribute("error");
%>
<html>
<head><title>Added fruit reservation</title></head>
<body>
<h2>Added fruit reservation</h2>
<% if(error != null) { %>
    <p style="color:red;"><%= error %></p>
<% } %>
<form method="post" action="<%=request.getContextPath()%>/reserve/add">
    Fruit：
    <select name="fruitId" required>
        <% for(Fruit f : fruitList) { %>
            <option value="<%= f.getFruitId() %>"><%= f.getName() %> (來源：<%= f.getSourceCountry() %>)</option>
        <% } %>
    </select><br/>
    quantity：<input type="number" name="quantity" min="1" required/><br/>
    Appointment date (within 14 days)：<input type="date" name="reserveDate" required min="<%= java.time.LocalDate.now() %>" max="<%= java.time.LocalDate.now().plusDays(14) %>"/><br/>
    <button type="submit">reserve</button>
</form>
<a href="<%=request.getContextPath()%>/reserve/list">Back reserve list</a>
</body>
</html>