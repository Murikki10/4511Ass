<%@ page import="it.ass.model.User" %>
<%
    User user = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="zh-Hant">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Dashboard</title>
        <style>
            body {
                font-family: "Microsoft JhengHei", Arial, sans-serif;
                background-color: #f4f7fa;
                margin: 0;
                padding: 20px;
                color: #333;
            }
            h2 {
                color: #2c3e50;
                margin-bottom: 10px;
            }
            p.city-info {
                font-size: 16px;
                margin-bottom: 30px;
                color: #555;
            }
            hr {
                border: none;
                border-top: 1px solid #ddd;
                margin: 30px 0 20px 0;
            }
            h3 {
                margin-bottom: 15px;
                color: #34495e;
                border-left: 5px solid #2980b9;
                padding-left: 10px;
            }
            ul {
                list-style: none;
                padding-left: 0;
                margin-bottom: 40px;
            }
            ul li {
                margin-bottom: 12px;
            }
            ul li a {
                text-decoration: none;
                color: #2980b9;
                font-weight: 600;
                padding: 8px 12px;
                display: inline-block;
                border-radius: 4px;
                transition: background-color 0.3s ease;
            }
            ul li a:hover {
                background-color: #2980b9;
                color: white;
            }
            .card {
                background-color: white;
                padding: 25px 30px;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
                max-width: 600px;
                margin-bottom: 40px;
            }
            .logout-link {
                display: inline-block;
                background-color: #e74c3c;
                color: white;
                text-decoration: none;
                font-weight: bold;
                padding: 12px 24px;
                border-radius: 6px;
                transition: background-color 0.3s ease;
            }
            .logout-link:hover {
                background-color: #c0392b;
            }
            @media (max-width: 640px) {
                body {
                    padding: 15px 10px;
                }
                .card {
                    padding: 20px;
                    max-width: 100%;
                }
                ul li a {
                    padding: 10px;
                    font-size: 14px;
                }
            }
        </style>
    </head>
    <body>

        <h2>welcome,<%= user.getUsername()%>!(<%= user.getRole()%>)</h2>
        <p class="city-info">Your city:<%= user.getCity()%></p>

        <% if ("manager".equals(user.getRole())) {%>
        <div class="card" style="border-left: 5px solid #27ae60;">
            <h3>Administrator Functions</h3>
            <ul>
                <li><a href="<%=request.getContextPath()%>/user/list">User Management</a></li>
                <li><a href="<%=request.getContextPath()%>/fruit/list">Fruit management</a></li>
                <li><a href="<%=request.getContextPath()%>/report/dashboard">Reporting and Analysis</a></li>
            </ul>
        </div>
        <% } %>

        <% if ("shop".equals(user.getRole())) {%>
        <div class="card" style="border-left: 5px solid #2980b9;">
            <h3>Store staff function</h3>
            <ul>
                <li><a href="<%=request.getContextPath()%>/reserve/list">Fruit Reservation</a></li>
                <li><a href="<%=request.getContextPath()%>/borrow/list">Borrowing Fruit</a></li>
                <li><a href="<%=request.getContextPath()%>/shop/stocklist">Store Fruit Stock List</a></li>
                <li><a href="<%=request.getContextPath()%>/order/history">Order History</a></li>
            </ul>
        </div>
        <% } %>

        <% if ("warehouse".equals(user.getRole())) {%>
        <div class="card" style="border-left: 5px solid #f39c12;">
            <h3>Warehouse staff functions</h3>
            <ul>
                <li><a href="<%=request.getContextPath()%>/warehouse_stock.jsp">Inventory Management</a></li>
                <li><a href="<%=request.getContextPath()%>/warehouse/requests">Reservation and borrowing application review</a></li>
                <li><a href="<%=request.getContextPath()%>/warehouse/delivery">Delivery Scheduling</a></li>
                <li><a href="<%=request.getContextPath()%>/inventory/update">Inventory Update</a></li>
            </ul>
        </div>
        <% }%>

        <a href="<%=request.getContextPath()%>/logout.jsp" class="logout-link">Sign out</a>

    </body>
</html>