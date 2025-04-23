<%@ page import="it.ass.model.User" %>
<%
  User user = (User) session.getAttribute("user");
%>
<h2>Welcome, <%= user.getUsername() %>! (Role: <%= user.getRole() %>)</h2>
<p>Your City: <%= user.getCity() %></p>

<% if ("manager".equals(user.getRole())) { %>
<hr>
<h3>Admin Functions</h3>
<ul>
    <li><a href="<%=request.getContextPath()%>/user/list">User Management</a></li>
    <li><a href="<%=request.getContextPath()%>/fruit/list">Fruit Management</a></li>
    <li><a href="<%=request.getContextPath()%>/report/dashboard">Reports & Analytics</a></li>
</ul>
<% } %>

<% if ("shop".equals(user.getRole())) { %>
<hr>
<h3>Shop Staff Functions</h3>
<ul>
    <li><a href="<%=request.getContextPath()%>/reserve/list">Fruit Reservation</a></li>
    <li><a href="<%=request.getContextPath()%>/borrow/list">Borrow Fruit</a></li>
    <li><a href="<%=request.getContextPath()%>/shop/stocklist">Fruit Stock List (Shop)</a></li>
    <li><a href="<%=request.getContextPath()%>/order/history">Order History</a></li>
</ul>
<% } %>

<% if ("warehouse".equals(user.getRole())) { %>
<hr>
<h3>Warehouse Staff Functions</h3>
<ul>
    <li><a href="<%=request.getContextPath()%>/warehouse_stock.jsp">Stock Management</a></li>
    <li><a href="<%=request.getContextPath()%>/warehouse/requests">Approve Reservations & Borrow Requests</a></li>
    <li><a href="<%=request.getContextPath()%>/warehouse/delivery">Delivery Scheduling</a></li>
    <li><a href="<%=request.getContextPath()%>/inventory/update">Update Inventory</a></li>
</ul>
<% } %>

<a href="<%=request.getContextPath()%>/logout.jsp">Logout</a>