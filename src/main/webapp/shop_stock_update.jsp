<%@ page import="java.util.List,it.ass.model.FruitStock" %>
<%
    List<FruitStock> stockDetails = (List<FruitStock>) request.getAttribute("stockDetails");
%>
<html>
    <head><title>Inventory Update</title></head>
    <body>
        <h2>Inventory Update</h2>
        <form action="stockupdate" method="post">
            <table border="1" cellpadding="5">
                <tr><th>Inventory ID</th><th>Place Name</th><th>Current Inventory</th><th>New Stock Quantity</th></tr>
                        <%
                            for (FruitStock fs : stockDetails) {
                        %>
                <tr>
                    <td><%= fs.getStockId()%></td>
                    <td><%= fs.getLocationName()%></td>
                    <td><%= fs.getQuantity()%></td>
                    <td>
                        <input type="hidden" name="stockId" value="<%= fs.getStockId()%>" />
                        <input type="hidden" name="fruitId" value="<%= fs.getFruitId()%>" />
                        <input type="number" name="quantity" min="0" required />
                    </td>
                </tr>
                <% }%>
            </table>
            <input type="submit" value="Update Inventory" />
        </form>
        <a href="stocklist">Back to stock list</a>
    </body>
</html>