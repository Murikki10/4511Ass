<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List,it.ass.model.User" %>
<%
    List<User> list = (List<User>)request.getAttribute("userList");
    if (list != null) {
        for (User u : list) {
%>
<tr>
    <td><%= u.getUserId() %></td>
    <td><%= u.getUsername() %></td>
    <td><%= u.getRole() %></td>
    <td><%= u.getCity() %></td>
    <td>
        <a href="<%=request.getContextPath()%>/user/edit?id=<%= u.getUserId() %>">Edit</a>
        <a href="<%=request.getContextPath()%>/user/delete?id=<%= u.getUserId() %>">Delete</a>
    </td>
</tr>
<%
        }
    } else {
%>
<tr>
    <td colspan="5">No user list found.</td>
</tr>
<%
    }
%>