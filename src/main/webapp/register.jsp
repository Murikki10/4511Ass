<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Register Page</title>
  <script>
    function onRoleChange() {
      var roleSelect = document.getElementById("role");
      var shopIdDiv = document.getElementById("shopIdDiv");
      if (roleSelect.value === "shop") {
        shopIdDiv.style.display = "block";
        // 設定 shopId 欄位為必填
        document.getElementById("shopId").required = true;
      } else {
        shopIdDiv.style.display = "none";
        // 不必填
        document.getElementById("shopId").required = false;
        // 清空欄位值
        document.getElementById("shopId").value = "";
      }
    }
    window.onload = function() {
      onRoleChange(); // 頁面載入時執行一次，確保顯示狀態正確
    }
  </script>
</head>
<body>
  <h2>User Register</h2>

  <form action="${pageContext.request.contextPath}/register" method="post">
    <input type="text" name="username" placeholder="Username" required><br/>
    <input type="password" name="password" placeholder="Password" required><br/>
    <input type="text" name="city" placeholder="City" required><br/>

    <div id="shopIdDiv" style="display:none;">
      <input type="number" name="shopId" id="shopId" placeholder="Shop ID"><br/>
    </div>

    <select name="role" id="role" required onchange="onRoleChange()">
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