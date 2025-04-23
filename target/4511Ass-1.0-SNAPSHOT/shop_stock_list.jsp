<%@ page import="java.util.List,it.ass.model.FruitStockSummary" %>
<%
    List<FruitStockSummary> stockList = (List<FruitStockSummary>) request.getAttribute("stockList");
%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Fruit Inventory List</title>
    <style>
        body {
            font-family: "Microsoft JhengHei", Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 20px;
            color: #333;
        }
        h2 {
            color: #2c3e50;
            margin-bottom: 20px;
        }
        .btn {
            display: inline-block;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 4px;
            margin-right: 10px;
            transition: background-color 0.3s ease;
            font-size: 14px;
        }
        .btn:hover {
            background-color: #2980b9;
        }
        table {
            width: 100%;
            max-width: 960px;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 0 8px rgba(0,0,0,0.1);
            margin-top: 10px;
        }
        th, td {
            padding: 14px 20px;
            border: 1px solid #ddd;
            text-align: center;
            font-size: 16px;
        }
        th {
            background-color: #2980b9;
            color: white;
            font-weight: bold;
        }
        tr:nth-child(even) {
            background-color: #f2f6fb;
        }
        tr:hover {
            background-color: #d0e7ff;
        }
        @media (max-width: 600px) {
            table, thead, tbody, th, td, tr {
                display: block;
            }
            thead tr {
                position: absolute;
                top: -9999px;
                left: -9999px;
            }
            tr {
                border: 1px solid #ccc;
                margin-bottom: 15px;
                background-color: white;
                box-shadow: 0 0 5px rgba(0,0,0,0.1);
                border-radius: 5px;
                padding: 10px;
            }
            td {
                border: none;
                border-bottom: 1px solid #eee;
                position: relative;
                padding-left: 50%;
                text-align: left;
                font-size: 14px;
            }
            td:before {
                position: absolute;
                top: 14px;
                left: 15px;
                width: 45%;
                padding-right: 10px;
                white-space: nowrap;
                font-weight: bold;
                color: #555;
            }
            td:nth-of-type(1):before { content: "Fruit ID"; }
            td:nth-of-type(2):before { content: "Fruit Name"; }
            td:nth-of-type(3):before { content: "Total Inventory"; }
            td:nth-of-type(4):before { content: "operate"; }
            .btn {
                padding: 6px 12px;
                font-size: 13px;
            }
        }
    </style>
</head>
<body>
    <h2>Fruit inventory in the city</h2>
    <p>
        <a href="<%=request.getContextPath()%>/shop/stockadd" class="btn">New Inventory</a>
        <a href="<%=request.getContextPath()%>/dashboard.jsp" class="btn" style="background-color:#7f8c8d;">Back To Home</a>
    </p>

    <table>
        <thead>
            <tr>
                <th>Fruit ID</th>
                <th>Fruit Name</th>
                <th>Total Inventory</th>
                <th>operate</th>
            </tr>
        </thead>
        <tbody>
            <% if (stockList != null && !stockList.isEmpty()) {
                for (FruitStockSummary fs : stockList) {
            %>
            <tr>
                <td><%= fs.getFruitId() %></td>
                <td><%= fs.getFruitName() %></td>
                <td><%= fs.getTotalQuantity() %></td>
                <td><a href="<%=request.getContextPath()%>/shop/stockupdate?fruitId=<%= fs.getFruitId() %>" class="btn" style="background-color:#27ae60;">Update Inventory</a></td>
            </tr>
            <%  }
               } else { %>
            <tr><td colspan="4" style="text-align:center;">No stock information</td></tr>
            <% } %>
        </tbody>
    </table>
</body>
</html>