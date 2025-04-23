<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List,it.ass.model.User,it.ass.model.Shop" %>
<%
    User user = (User) request.getAttribute("user");
    List<Shop> shopList = (List<Shop>) request.getAttribute("shopList");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Edit User</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f7fc;
                margin: 20px;
                color: #333;
                display: flex;
                justify-content: center;
            }
            form {
                background-color: #fff;
                padding: 30px 25px;
                border-radius: 8px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
                max-width: 400px;
                width: 100%;
                box-sizing: border-box;
            }
            input[type="text"], select {
                width: 100%;
                padding: 10px 12px;
                margin: 15px 0 10px 0;
                font-size: 15px;
                border: 1px solid #ccc;
                border-radius: 5px;
                transition: border-color 0.3s ease;
            }
            input[type="text"]:focus, select:focus {
                border-color: #3498db;
                outline: none;
            }
            label {
                font-weight: 600;
                color: #555;
                display: block;
                margin-top: 15px;
            }
            button {
                padding: 12px 0;
                font-size: 16px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-weight: 600;
                margin-top: 20px;
                width: 48%;
                box-sizing: border-box;
            }
            button[type="submit"] {
                background-color: #3498db;
                color: white;
                float: left;
                transition: background-color 0.3s ease;
            }
            button[type="submit"]:hover {
                background-color: #2980b9;
            }
            button[type="button"] {
                background-color: #bdc3c7;
                color: #444;
                float: right;
                transition: background-color 0.3s ease;
            }
            button[type="button"]:hover {
                background-color: #a6acb1;
            }
            /* Clear floats */
            form::after {
                content: "";
                display: table;
                clear: both;
            }
            @media (max-width: 480px) {
                form {
                    padding: 20px 15px;
                }
                button {
                    width: 100%;
                    margin-top: 12px;
                    float: none;
                }
            }
        </style>
    </head>
    <body>
        <form method="post">
            <input type="hidden" name="userId" value="<%= user.getUserId()%>" />

            <label for="username">Username</label>
            <input type="text" id="username" name="username" value="<%= user.getUsername()%>" required />

            <label for="city">City</label>
            <input type="text" id="city" name="city" value="<%= user.getCity()%>" required />

            <label for="role">Role</label>
            <select id="role" name="role" required>
                <option value="shop" <%= "shop".equals(user.getRole()) ? "selected" : ""%>>Shop</option>
                <option value="warehouse" <%= "warehouse".equals(user.getRole()) ? "selected" : ""%>>Warehouse</option>
                <option value="manager" <%= "manager".equals(user.getRole()) ? "selected" : ""%>>Manager</option>
            </select>

            <label for="shopId">Assign Shop</label>
            <select name="shopId" id="shopId" required>
                <option value="">-- Select Shop --</option>
                <%
                    if (shopList != null) {
                        for (Shop shop : shopList) {
                            String selected = (shop.getShopId() == user.getShopId()) ? "selected" : "";
                %>
                <option value="<%= shop.getShopId()%>" <%= selected%>><%= shop.getShopName()%></option>
                <%
                        }
                    }
                %>
            </select>

            <button type="submit">Save</button>
            <button type="button" onclick="window.location.href = '<%=request.getContextPath()%>/user/list'">Back</button>
        </form>
    </body>
</html>