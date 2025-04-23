<%@ page import="java.util.List,it.ass.model.Fruit" %>
<%
    List<Fruit> fruitList = (List<Fruit>) request.getAttribute("fruitList");
    String locationName = (String) request.getAttribute("locationName");
%>
<html>
<head><title>Add New Stock</title></head>
<body>
<h2>Add New Stock</h2>

<% if (request.getAttribute("error") != null) { %>
    <p style="color:red;"><%= request.getAttribute("error") %></p>
<% } %>

<form action="<%=request.getContextPath()%>/shop/stockadd" method="post">
    <label>Fruit:
        <select name="fruitId" required>
            <option value="">-- Select Fruit --</option>
            <% for(Fruit f : fruitList) { %>
                <option value="<%= f.getFruitId() %>"><%= f.getName() %></option>
            <% } %>
        </select>
    </label>
    <br/><br/>

    <label>Location: 
        <input type="text" value="<%= locationName %>" readonly />
        <input type="hidden" name="locationName" value="<%= locationName %>" />
    </label>
    <br/><br/>

    <label>Quantity: <input type="number" name="quantity" min="0" required /></label>
    <br/><br/>

    <input type="submit" value="Add Stock" />
</form>

<p><a href="<%=request.getContextPath()%>/shop/stocklist">Back to Stock List</a></p>
</body>
</html>