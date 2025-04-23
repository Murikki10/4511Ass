<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List,it.ass.model.User" %>
<style>
    table {
        border-collapse: collapse;
        width: 100%;
    }
    th, td {
        text-align: left;
        padding: 8px;
        border-bottom: 1px solid #ddd;
    }
    th {
        background-color: #f2f2f2;
    }
    a {
        margin-right: 10px;
    }
</style>

<table>
    <thead>
        <tr>
            <th>User ID</th>
            <th>Username</th>
            <th>Role</th>
            <th>City</th>
            <th>Shop Name</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <%
            List<User> list = (List<User>) request.getAttribute("userList");
            if (list != null && !list.isEmpty()) {
                for (User u : list) {

                    String shopName = (String) request.getAttribute("shopName_" + u.getUserId());
        %>
        <tr>
            <td><%= u.getUserId()%></td>
            <td><%= u.getUsername()%></td>
            <td><%= u.getRole()%></td>
            <td><%= u.getCity()%></td>
            <td><%= (shopName != null) ? shopName : "N/A"%></td>
            <td>
                <a href="<%=request.getContextPath()%>/user/edit?id=<%= u.getUserId()%>">Edit</a>
                <a href="<%=request.getContextPath()%>/user/delete?id=<%= u.getUserId()%>" onclick="return confirm('確定刪除此用戶？')">Delete</a>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="6">No user list found.</td>
        </tr>
        <%
            }
        %>
    </tbody>
</table>

<br/>
<button type="button" onclick="window.location.href = '<%=request.getContextPath()%>/dashboard.jsp'">Back to Home</button>