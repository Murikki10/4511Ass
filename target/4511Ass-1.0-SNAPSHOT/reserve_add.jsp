<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List,it.ass.model.Fruit" %>
<%
    List<Fruit> fruitList = (List<Fruit>) request.getAttribute("fruitList");
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Add Fruit Reservation</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f7f9fc;
                margin: 20px;
                color: #333;
            }
            h2 {
                text-align: center;
                color: #2c3e50;
                margin-bottom: 25px;
            }
            form {
                max-width: 450px;
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
                margin-bottom: 6px;
                color: #34495e;
                margin-top: 15px;
            }
            select, input[type="number"], input[type="date"] {
                width: 100%;
                padding: 10px 12px;
                font-size: 15px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
                transition: border-color 0.3s ease;
            }
            select:focus, input[type="number"]:focus, input[type="date"]:focus {
                border-color: #3498db;
                outline: none;
            }
            button {
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
            button:hover {
                background-color: #2980b9;
            }
            .error-message {
                color: #e74c3c;
                font-weight: 600;
                text-align: center;
                margin-bottom: 20px;
            }
            a.back-link {
                display: block;
                text-align: center;
                margin-top: 20px;
                color: #2980b9;
                font-weight: 600;
                text-decoration: none;
                font-size: 14px;
            }
            a.back-link:hover {
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
        <h2>Add Fruit Reservation</h2>
        <% if (error != null) {%>
        <div class="error-message"><%= error%></div>
        <% }%>
        <form method="post" action="<%=request.getContextPath()%>/reserve/add">
            <label for="fruitId">Fruit:</label>
            <select name="fruitId" id="fruitId" required>
                <option value="">-- Select Fruit --</option>
                <% for (Fruit f : fruitList) {%>
                <option value="<%= f.getFruitId()%>"><%= f.getName()%> (Origin: <%= f.getSourceCountry()%>)</option>
                <% }%>
            </select>

            <label for="quantity">Quantity:</label>
            <input type="number" name="quantity" id="quantity" min="1" required />

            <label for="reserveDate">Appointment Date (within 14 days):</label>
            <input type="date" name="reserveDate" id="reserveDate" required 
                   min="<%= java.time.LocalDate.now()%>" 
                   max="<%= java.time.LocalDate.now().plusDays(14)%>" />

            <button type="submit">Reserve</button>
        </form>

        <a href="<%=request.getContextPath()%>/reserve/list" class="back-link">Back to Reservation List</a>
    </body>
</html>