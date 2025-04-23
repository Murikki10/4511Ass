<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List,it.ass.model.Fruit" %>
<html>
<head><title>Fruit List</title></head>
<body>
<h2>List of fruit types</h2>
<a href="<%=request.getContextPath()%>/fruit/add">Add Fruit</a><br/><br/>
<table border="1" cellpadding="5">
    <tr><th>ID</th><th>Fruit Name</th><th>Origin</th><th>operate</th></tr>
    <%
        List<Fruit> list = (List<Fruit>)request.getAttribute("fruitList");
        if (list != null) {
            for (Fruit f : list) {
    %>
    <tr>
        <td><%= f.getFruitId() %></td>
        <td><%= f.getName() %></td>
        <td><%= f.getSourceCountry() %></td>
        <td>
            <a href="<%=request.getContextPath()%>/fruit/edit?id=<%= f.getFruitId() %>">Edit</a>
            <a href="<%=request.getContextPath()%>/fruit/delete?id=<%= f.getFruitId() %>" onclick="return confirm('確定刪除?');">Delete</a>
        </td>
    </tr>
    <%
            }
        } else {
    %>
    <tr><td colspan="4">No Information</td></tr>
    <% } %>
</table>
<a href="<%=request.getContextPath()%>/dashboard.jsp">Back to home page</a>
</body>
</html>