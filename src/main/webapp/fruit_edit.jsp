<%@ page contentType="text/html; charset=UTF-8" %>
<%
    it.ass.model.Fruit fruit = (it.ass.model.Fruit) request.getAttribute("fruit");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Edit Fruit</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f9f9f9;
                margin: 20px;
                color: #333;
            }
            h2 {
                color: #2c3e50;
                margin-bottom: 25px;
                text-align: center;
            }
            form {
                max-width: 450px;
                margin: 0 auto;
                background-color: white;
                padding: 30px 25px;
                border-radius: 8px;
                box-shadow: 0 2px 12px rgba(0,0,0,0.1);
            }
            label {
                display: block;
                font-weight: 600;
                margin-bottom: 8px;
                margin-top: 20px;
                color: #34495e;
            }
            input[type="text"] {
                width: 100%;
                padding: 10px 12px;
                font-size: 15px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
                transition: border-color 0.3s ease;
            }
            input[type="text"]:focus {
                border-color: #2980b9;
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
            a.back-link {
                display: block;
                text-align: center;
                margin-top: 20px;
                color: #2980b9;
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
        <h2>Edit Fruit</h2>
        <form method="post" action="<%=request.getContextPath()%>/fruit/edit">
            <input type="hidden" name="fruitId" value="<%= fruit.getFruitId()%>" />

            <label for="name">Fruit Name:</label>
            <input type="text" id="name" name="name" value="<%= fruit.getName()%>" required />

            <label for="sourceCountry">Origin:</label>
            <input type="text" id="sourceCountry" name="sourceCountry" value="<%= fruit.getSourceCountry()%>" required />

            <button type="submit">Update</button>
        </form>
        <a href="<%=request.getContextPath()%>/fruit/list" class="back-link">Back to Fruit List</a>
    </body>
</html>