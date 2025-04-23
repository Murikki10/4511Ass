<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List,it.ass.model.User,it.ass.model.Shop" %>
<%
    User user = (User) request.getAttribute("user");
    List<Shop> shopList = (List<Shop>) request.getAttribute("shopList");
%>
<form method="post">
    <input type="hidden" name="userId" value="<%= user.getUserId() %>"/>
    <input type="text" name="username" value="<%= user.getUsername() %>" required/><br/>
    <input type="text" name="city" value="<%= user.getCity() %>" required/><br/>
    <select name="role" required>
        <option value="shop" <%= "shop".equals(user.getRole()) ? "selected" : "" %>>Shop</option>
        <option value="warehouse" <%= "warehouse".equals(user.getRole()) ? "selected" : "" %>>Warehouse</option>
        <option value="manager" <%= "manager".equals(user.getRole()) ? "selected" : "" %>>Manager</option>
    </select><br/>

    <label for="shopId">Assign Shop:</label>
    <select name="shopId" id="shopId" required>
        <option value="">-- Select Shop --</option>
    <%
        if (shopList != null) {
            for (Shop shop : shopList) {
                String selected = (shop.getShopId() == user.getShopId()) ? "selected" : "";
    %>
        <option value="<%= shop.getShopId() %>" <%= selected %>><%= shop.getShopName() %></option>
    <%
            }
        }
    %>
    </select><br/>

    <button type="submit">Save</button>
    <button type="button" onclick="window.location.href='<%=request.getContextPath()%>/user/list'">Back</button>
</form>