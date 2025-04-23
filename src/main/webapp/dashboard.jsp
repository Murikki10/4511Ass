<%@ page import="it.ass.model.User" %>
<%
  User user = (User) session.getAttribute("user");
%>
<h2>Welcome <%= user.getUsername() %>?<%= user.getRole() %>?</h2>
<p>You Came From <%= user.getCity() %></p>

<% if ("manager".equals(user.getRole())) { %>
    <hr>
    <h3>Admin Function</h3>
    <ul>
      <li><a href="<%=request.getContextPath()%>/user/list">User Manager</a></li>
      <li><a href="fruit_manage.jsp">Firut Manager</a></li>
    </ul>
<% } %>
<% if ("shop".equals(user.getRole())) { %>
    <hr>
    <h3>Shop Function</h3>
    <ul>
      <li><a href="shop_order.jsp">Order Firut</a></li>
    </ul>
<% } %>
<% if ("warehouse".equals(user.getRole())) { %>
    <hr>
    <h3>Warehouse Function</h3>
    <ul>
      <li><a href="warehouse_stock.jsp">Clacker Manager</a></li>
    </ul>
<% } %>

<a href="logout.jsp">Logout</a>