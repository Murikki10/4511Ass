<%@ page import="java.util.List,it.ass.model.FruitStockSummary" %>
<%
    List<FruitStockSummary> stockList = (List<FruitStockSummary>) request.getAttribute("stockList");
%>
<html>
<head><title>Fruit Inventory List</title></head>
<body>
    <h2>Fruit stocks in your city</h2>

    <p>
        <a href="<%=request.getContextPath()%>/shop/stockadd">Add New Stock</a> |
        <a href="<%=request.getContextPath()%>/dashboard.jsp">Back to Dashboard</a>
    </p>

    <table border="1" cellpadding="5">
        <tr><th>Fruit ID</th><th>Fruit Name</th><th>Total inventory</th><th>operate</th></tr>
        <%
            for (FruitStockSummary fs : stockList) {
        %>
        <tr>
            <td><%= fs.getFruitId() %></td>
            <td><%= fs.getFruitName() %></td>
            <td><%= fs.getTotalQuantity() %></td>
            <td><a href="<%=request.getContextPath()%>/shop/stockupdate?fruitId=<%= fs.getFruitId() %>">Update Inventory</a></td>
        </tr>
        <% } %>
    </table>
</body>
</html>