<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Login</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f2f6fc;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
                color: #333;
            }
            .login-container {
                background-color: #fff;
                padding: 30px 40px;
                border-radius: 8px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
                width: 320px;
                box-sizing: border-box;
                text-align: center;
            }
            h2 {
                margin-bottom: 25px;
                color: #2c3e50;
            }
            input[type="text"], input[type="password"] {
                width: 100%;
                padding: 10px 12px;
                margin: 10px 0 20px 0;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-size: 15px;
                box-sizing: border-box;
                transition: border-color 0.3s ease;
            }
            input[type="text"]:focus, input[type="password"]:focus {
                border-color: #3498db;
                outline: none;
            }
            button {
                width: 100%;
                padding: 12px 0;
                background-color: #3498db;
                border: none;
                color: white;
                font-weight: bold;
                font-size: 16px;
                border-radius: 5px;
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
            .register-link {
                margin-top: 20px;
                display: block;
                color: #3498db;
                text-decoration: none;
                font-size: 14px;
            }
            .register-link:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <div class="login-container">
            <h2>Login</h2>

            <form action="${pageContext.request.contextPath}/login" method="post">
                <input type="text" name="username" placeholder="Username" required />
                <input type="password" name="password" placeholder="Password" required />
                <button type="submit">Login</button>
            </form>

            <c:if test="${not empty error}">
                <div class="error-message">${error}</div>
            </c:if>

            <a href="${pageContext.request.contextPath}/register" class="register-link">Register</a>
        </div>
    </body>
</html>