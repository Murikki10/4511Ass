<%@ page contentType="text/html; charset=UTF-8" %>
<%
    it.ass.model.User user = (it.ass.model.User)request.getAttribute("user");
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
    <button type="submit">Save</button>
</form>