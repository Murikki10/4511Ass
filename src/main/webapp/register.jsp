<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Register Page</title></head>
<body>
  <h2>User Register</h2>

  <form action="${pageContext.request.contextPath}/register" method="post">
    <input type="text" name="username" placeholder="Username" required><br/>
    <input type="password" name="password" placeholder="Password" required><br/>
    <input type="text" name="city" placeholder="City" required><br/>
    <select name="role" required>
      <option value="shop">Shop</option>
      <option value="warehouse">Warehouse</option>
      <option value="manager">Manager</option>
    </select><br/>
    <button type="submit">Register</button>
  </form>

  <div style="color:red">${error}</div>
  <a href="login.jsp">Back to login</a>
</body>
</html>
