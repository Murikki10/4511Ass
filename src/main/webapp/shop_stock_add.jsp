<%@ page import="java.util.List,it.ass.model.Fruit" %>
<%
    List<Fruit> fruitList = (List<Fruit>) request.getAttribute("fruitList");
    String locationName = (String) request.getAttribute("locationName");
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Add New Stock</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f7fb;
                margin: 20px;
                color: #333;
            }
            h2 {
                text-align: center;
                color: #2c3e50;
                margin-bottom: 30px;
            }
            form {
                max-width: 400px;
                margin: 0 auto;
                background: white;
                padding: 30px 25px;
                border-radius: 8px;
                box-shadow: 0 3px 12px rgba(0,0,0,0.1);
                box-sizing: border-box;
            }
            label {
                display: block;
                font-weight: 600;
                margin-bottom: 8px;
                color: #34495e;
                margin-top: 20px;
            }
            select, input[type="text"], input[type="number"] {
                width: 100%;
                padding: 10px 12px;
                font-size: 15px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
                transition: border-color 0.3s ease;
            }
            select:focus, input[type="number"]:focus {
                border-color: #3498db;
                outline: none;
            }
            input[readonly] {
                background-color: #e9ecef;
                cursor: not-allowed;
            }
            input[type="submit"] {
                margin-top: 30px;
                width: 100%;
                background-color: #3498db;
                color: white;
                font-weight: bold;
                padding: 12px 0;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
                transition: background-color 0.3s ease;
            }
            input[type="submit"]:hover {
                background-color: #2980b9;
            }
            .error-message {
                color: #e74c3c;
                font-weight: 600;
                text-align: center;
                margin-bottom: 20px;
            }
            p.back-link {
                text-align: center;
                margin-top: 25px;
            }
            p.back-link a {
                color: #2980b9;
                font-weight: 600;
                text-decoration: none;
                font-size: 14px;
            }
            p.back-link a:hover {
                text-decoration: underline;
            }
            @media (max-width: 480px) {
                body {
                    margin: 10px;
                }
                form {
                    padding: 20px 15px;
                }
            }
        </style>
    </head>
    <body>
        <h2>Add New Stock</h2>

        <% if (error != null) {%>
        <div class="error-message"><%= error%></div>
        <% }%>

        <form action="<%=request.getContextPath()%>/shop/stockadd" method="post">
            <label for="fruitId">Fruit:</label>
            <select name="fruitId" id="fruitId" required>
                <option value="">-- Select Fruit --</option>
                <% for (Fruit f : fruitList) {%>
                <option value="<%= f.getFruitId()%>"><%= f.getName()%></option>
                <% }%>
            </select>

            <label for="location">Location:</label>
            <input type="text" id="location" value="<%= locationName%>" readonly />

            <label for="quantity">Quantity:</label>
            <input type="number" name="quantity" id="quantity" min="0" required />

            <input type="submit" value="Add Stock" />
        </form>

        <p class="back-link"><a href="<%=request.getContextPath()%>/shop/stocklist">Back to Stock List</a></p>
    </body>
</html>