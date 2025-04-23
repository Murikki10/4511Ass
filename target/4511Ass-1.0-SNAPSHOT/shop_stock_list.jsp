<%@ page import="java.util.List,it.ass.model.FruitStockSummary" %>
<%
    List<FruitStockSummary> cityStockList = (List<FruitStockSummary>) request.getAttribute("cityStockList");
    List<FruitStockSummary> myShopStockList = (List<FruitStockSummary>) request.getAttribute("myShopStockList");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <title>Fruit Inventory Summary</title>
        <style>
            body {
                font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
                background: #f0f4f8;
                margin: 20px;
                color: #333;
            }
            h2 {
                color: #2c3e50;
                border-bottom: 3px solid #2980b9;
                padding-bottom: 6px;
                margin-top: 40px;
                font-weight: 700;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                background: white;
                box-shadow: 0 0 8px rgba(0,0,0,0.1);
                border-radius: 6px;
                overflow: hidden;
            }
            thead {
                background-color: #2980b9;
                color: #fff;
                font-weight: 600;
            }
            thead th {
                padding: 12px 15px;
                text-align: center;
            }
            tbody tr:nth-child(even) {
                background-color: #ecf0f1;
            }
            tbody tr:hover {
                background-color: #d1e7fd;
            }
            tbody td {
                text-align: center;
                padding: 12px 15px;
                border-bottom: 1px solid #ddd;
            }
            .no-data {
                text-align: center;
                padding: 20px;
                color: #999;
                font-style: italic;
            }
        </style>
    </head>
    <body>
        <h2>My Shop Stock Summary</h2>
        <table>
            <thead>
                <tr>
                    <th>Fruit ID</th>
                    <th>Fruit Name</th>
                    <th>Total Quantity</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% if (myShopStockList != null && !myShopStockList.isEmpty()) {
                    for (FruitStockSummary fss : myShopStockList) {%>
                <tr>
                    <td><%= fss.getFruitId()%></td>
                    <td><%= fss.getFruitName()%></td>
                    <td><%= fss.getTotalQuantity()%></td>
                    <td><a href="stockupdate?fruitId=<%= fss.getFruitId()%>" style="color:#2980b9; text-decoration:none; font-weight:600;">Update</a></td>
                </tr>
                <%  }
            } else { %>
                <tr>
                    <td colspan="4" class="no-data">No inventory data for your shop.</td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <h2>City Stock Summary</h2>
        <table>
            <thead>
                <tr>
                    <th>Fruit ID</th>
                    <th>Fruit Name</th>
                    <th>Total Quantity</th>
                    <!-- Action column removed -->
                </tr>
            </thead>
            <tbody>
                <% if (cityStockList != null && !cityStockList.isEmpty()) {
                    for (FruitStockSummary fss : cityStockList) {%>
                <tr>
                    <td><%= fss.getFruitId()%></td>
                    <td><%= fss.getFruitName()%></td>
                    <td><%= fss.getTotalQuantity()%></td>
                </tr>
                <%  }
            } else { %>
                <tr>
                    <td colspan="3" class="no-data">No inventory data in the city.</td>
                </tr>
                <% }%>
            </tbody>
        </table>
    </body>
</html>