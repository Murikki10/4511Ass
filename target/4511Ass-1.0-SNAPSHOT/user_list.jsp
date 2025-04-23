<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List,it.ass.model.User" %>
<%
    List<User> list = (List<User>) request.getAttribute("userList");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>User List</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f8fafc;
                margin: 20px;
                color: #333;
            }
            h2 {
                text-align: center;
                color: #2c3e50;
                margin-bottom: 20px;
            }
            table {
                width: 100%;
                max-width: 960px;
                margin: 0 auto;
                border-collapse: collapse;
                background-color: #fff;
                box-shadow: 0 0 12px rgba(0,0,0,0.1);
                border-radius: 8px;
                overflow: hidden;
            }
            thead {
                background-color: #2980b9;
                color: white;
                font-weight: bold;
            }
            th, td {
                padding: 14px 18px;
                border-bottom: 1px solid #ddd;
                text-align: left;
                font-size: 15px;
            }
            tbody tr:nth-child(even) {
                background-color: #f7faff;
            }
            tbody tr:hover {
                background-color: #d0e7ff;
            }
            a {
                color: #2980b9;
                text-decoration: none;
                margin-right: 12px;
                font-weight: 600;
            }
            a:hover {
                text-decoration: underline;
            }
            .btn-back {
                display: block;
                width: 160px;
                margin: 30px auto 0;
                padding: 12px 0;
                background-color: #3498db;
                color: white;
                font-weight: 700;
                text-align: center;
                border-radius: 6px;
                border: none;
                cursor: pointer;
                transition: background-color 0.3s ease;
                text-decoration: none;
            }
            .btn-back:hover {
                background-color: #2980b9;
            }
            @media (max-width: 700px) {
                table, thead, tbody, th, td, tr {
                    display: block;
                    width: 100%;
                }
                thead tr {
                    position: absolute;
                    top: -9999px;
                    left: -9999px;
                }
                tbody tr {
                    margin-bottom: 20px;
                    background-color: white;
                    box-shadow: 0 0 6px rgba(0,0,0,0.05);
                    border-radius: 8px;
                    padding: 15px;
                }
                tbody td {
                    border: none;
                    border-bottom: 1px solid #eee;
                    position: relative;
                    padding-left: 50%;
                    text-align: left;
                    font-size: 14px;
                    white-space: normal;
                }
                tbody td:last-child {
                    border-bottom: none;
                }
                tbody td:before {
                    position: absolute;
                    top: 14px;
                    left: 15px;
                    width: 45%;
                    padding-right: 10px;
                    white-space: nowrap;
                    font-weight: 700;
                    color: #555;
                }
                tbody td:nth-of-type(1):before {
                    content: "User ID";
                }
                tbody td:nth-of-type(2):before {
                    content: "Username";
                }
                tbody td:nth-of-type(3):before {
                    content: "Role";
                }
                tbody td:nth-of-type(4):before {
                    content: "City";
                }
                tbody td:nth-of-type(5):before {
                    content: "Shop Name";
                }
                tbody td:nth-of-type(6):before {
                    content: "Actions";
                }
                a {
                    margin-right: 10px;
                    font-size: 14px;
                }
            }
        </style>
    </head>
    <body>
        <h2>User List</h2>
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
                        <a href="<%= request.getContextPath()%>/user/edit?id=<%= u.getUserId()%>">Edit</a>
                        <a href="<%= request.getContextPath()%>/user/delete?id=<%= u.getUserId()%>" onclick="return confirm('Are you sure you want to delete this user?')">Delete</a>
                    </td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="6" style="text-align:center;">No user list found.</td>
                </tr>
                <% }%>
            </tbody>
        </table>

        <button class="btn-back" type="button" onclick="window.location.href = '<%=request.getContextPath()%>/dashboard.jsp'">Back to Home</button>
    </body>
</html>