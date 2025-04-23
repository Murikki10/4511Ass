<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Update Fruit Stock</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f5f8fa;
                margin: 20px;
                color: #333;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
            }
            form {
                background: white;
                padding: 30px 25px;
                border-radius: 8px;
                box-shadow: 0 3px 12px rgba(0,0,0,0.1);
                max-width: 360px;
                width: 100%;
                box-sizing: border-box;
            }
            h2 {
                text-align: center;
                margin-bottom: 25px;
                color: #2c3e50;
            }
            label {
                display: block;
                font-weight: 600;
                margin-bottom: 6px;
                color: #34495e;
                margin-top: 15px;
            }
            input[type="text"], input[type="number"] {
                width: 100%;
                padding: 10px 12px;
                font-size: 15px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
                transition: border-color 0.3s ease;
            }
            input[type="text"]:focus, input[type="number"]:focus {
                border-color: #3498db;
                outline: none;
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
            @media (max-width: 400px) {
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
        <form action="updateStock" method="post">
            <h2>Update Fruit Stock</h2>

            <label for="fruitId">Fruit ID:</label>
            <input type="text" id="fruitId" name="fruitId" required />

            <label for="stock">New Stock Quantity:</label>
            <input type="number" id="stock" name="stock" min="0" required />

            <input type="submit" value="Update Stock" />
        </form>
    </body>
</html>