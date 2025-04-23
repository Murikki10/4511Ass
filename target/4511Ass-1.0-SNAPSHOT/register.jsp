<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>User Registration</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f5f8fa;
      margin: 0;
      padding: 20px;
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
      color: #333;
    }
    .register-container {
      background-color: white;
      padding: 30px 35px;
      border-radius: 8px;
      box-shadow: 0 3px 12px rgba(0,0,0,0.1);
      width: 320px;
      box-sizing: border-box;
      text-align: center;
    }
    h2 {
      margin-bottom: 25px;
      color: #2c3e50;
    }
    input[type="text"], input[type="password"], select {
      width: 100%;
      padding: 10px 12px;
      margin: 10px 0 18px 0;
      border-radius: 4px;
      border: 1px solid #ccc;
      font-size: 15px;
      box-sizing: border-box;
      transition: border-color 0.3s ease;
    }
    input[type="text"]:focus, input[type="password"]:focus, select:focus {
      border-color: #3498db;
      outline: none;
    }
    button {
      width: 100%;
      padding: 12px 0;
      background-color: #3498db;
      border: none;
      border-radius: 5px;
      color: white;
      font-weight: bold;
      font-size: 16px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }
    button:hover {
      background-color: #2980b9;
    }
    .error-message {
      color: #e74c3c;
      margin-bottom: 15px;
      font-weight: 600;
    }
    a.back-link {
      display: block;
      margin-top: 20px;
      color: #2980b9;
      text-decoration: none;
      font-size: 14px;
    }
    a.back-link:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>
  <div class="register-container">
    <h2>User Registration</h2>

    <form action="${pageContext.request.contextPath}/register" method="post">
      <input type="text" name="username" placeholder="Username" required />
      <input type="password" name="password" placeholder="Password" required />
      <input type="text" name="city" placeholder="City" required />
      <select name="role" required>
        <option value="" disabled selected>Select Role</option>
        <option value="shop">Shop</option>
        <option value="warehouse">Warehouse</option>
        <option value="manager">Manager</option>
      </select>
      <button type="submit">Register</button>
    </form>

    <c:if test="${not empty error}">
      <div class="error-message">${error}</div>
    </c:if>

    <a href="login.jsp" class="back-link">Back to Login</a>
  </div>
</body>
</html>