<%@ page import="java.util.List,it.ass.model.FruitStock" %>
<%
    List<FruitStock> stockDetails = (List<FruitStock>) request.getAttribute("stockDetails");
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Inventory Update</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f8fb;
                margin: 20px;
                color: #333;
            }
            h2 {
                text-align: center;
                color: #2c3e50;
                margin-bottom: 25px;
            }
            .error-message {
                color: #e74c3c;
                font-weight: 600;
                text-align: center;
                margin-bottom: 20px;
            }
            form {
                max-width: 800px;
                margin: 0 auto 30px auto;
                background: white;
                padding: 25px 20px;
                border-radius: 8px;
                box-shadow: 0 3px 12px rgba(0,0,0,0.1);
                box-sizing: border-box;
            }
            table {
                width: 100%;
                border-collapse: collapse;
            }
            th, td {
                padding: 12px 15px;
                border: 1px solid #ddd;
                text-align: center;
                font-size: 15px;
            }
            th {
                background-color: #2980b9;
                color: white;
                font-weight: 700;
            }
            tr:nth-child(even) {
                background-color: #f7faff;
            }
            tr:hover {
                background-color: #d0e7ff;
            }
            input[type="number"] {
                width: 80px;
                padding: 6px 8px;
                font-size: 14px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
                transition: border-color 0.3s ease;
            }
            input[type="number"]:focus {
                border-color: #3498db;
                outline: none;
            }
            input[type="submit"] {
                display: block;
                width: 100%;
                max-width: 300px;
                margin: 25px auto 0 auto;
                padding: 12px 0;
                background-color: #3498db;
                border: none;
                border-radius: 5px;
                color: white;
                font-weight: 700;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            input[type="submit"]:hover {
                background-color: #2980b9;
            }
            a.back-link {
                display: block;
                text-align: center;
                margin-top: 20px;
                font-weight: 600;
                color: #2980b9;
                text-decoration: none;
                font-size: 14px;
            }
            a.back-link:hover {
                text-decoration: underline;
            }
            @media (max-width: 700px) {
                form {
                    padding: 15px 10px;
                }
                table, tbody, tr, th, td {
                    display: block;
                    width: 100%;
                }
                thead {
                    display: none;
                }
                tr {
                    margin-bottom: 15px;
                    border: 1px solid #ccc;
                    border-radius: 6px;
                    box-shadow: 0 0 6px rgba(0,0,0,0.05);
                    background-color: white;
                    padding: 10px;
                }
                td {
                    border: none;
                    border-bottom: 1px solid #eee;
                    padding-left: 50%;
                    position: relative;
                    text-align: left;
                    font-size: 14px;
                    white-space: normal;
                }
                td:last-child {
                    border-bottom: none;
                }
                td:before {
                    position: absolute;
                    left: 15px;
                    top: 12px;
                    width: 45%;
                    padding-right: 10px;
                    white-space: nowrap;
                    font-weight: 700;
                    color: #555;
                    content: attr(data-label);
                }
                input[type="number"] {
                    width: 100%;
                    margin-top: 5px;
                }
            }
        </style>
    </head>
    <body>
        <h2>Inventory Update</h2>

        <% if (error != null) {%>
        <div class="error-message"><%= error%></div>
        <% } %>

        <form action="stockupdate" method="post">
            <table>
                <thead>
                    <tr>
                        <th>Inventory ID</th>
                        <th>Location</th>
                        <th>Current Quantity</th>
                        <th>New Stock Quantity</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (FruitStock fs : stockDetails) {
                    %>
                    <tr>
                        <td data-label="Inventory ID"><%= fs.getStockId()%></td>
                        <td data-label="Location"><%= fs.getLocationName()%></td>
                        <td data-label="Current Quantity"><%= fs.getQuantity()%></td>
                        <td data-label="New Stock Quantity">
                            <input type="hidden" name="stockId" value="<%= fs.getStockId()%>" />
                            <input type="hidden" name="fruitId" value="<%= fs.getFruitId()%>" />
                            <input type="number" name="quantity" min="0" required />
                        </td>
                    </tr>
                    <% }%>
                </tbody>
            </table>
            <input type="submit" value="Update Inventory" />
        </form>

        <a href="stocklist" class="back-link">Back to Stock List</a>
    </body>
</html>