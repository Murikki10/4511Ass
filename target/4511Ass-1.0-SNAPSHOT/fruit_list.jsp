<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List,it.ass.model.Fruit" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Fruit List</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f9f9f9;
                margin: 20px;
                color: #333;
            }
            h2 {
                color: #2c3e50;
                margin-bottom: 20px;
                text-align: center;
            }
            a.add-btn {
                display: inline-block;
                background-color: #3498db;
                color: white;
                padding: 10px 18px;
                border-radius: 5px;
                text-decoration: none;
                font-weight: 600;
                margin-bottom: 15px;
                transition: background-color 0.3s ease;
            }
            a.add-btn:hover {
                background-color: #2980b9;
            }
            table {
                width: 100%;
                max-width: 900px;
                margin: 0 auto 30px auto;
                border-collapse: collapse;
                background-color: white;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            th, td {
                padding: 12px 20px;
                border: 1px solid #ddd;
                text-align: center;
                font-size: 15px;
            }
            th {
                background-color: #2980b9;
                color: white;
                font-weight: bold;
            }
            tr:nth-child(even) {
                background-color: #f2f6fb;
            }
            tr:hover {
                background-color: #d0e7ff;
            }
            a.action-link {
                margin: 0 8px;
                color: #2980b9;
                text-decoration: none;
                font-weight: 600;
                cursor: pointer;
                transition: color 0.3s ease;
            }
            a.action-link:hover {
                color: #1c5980;
            }
            a.action-link.delete {
                color: #e74c3c;
            }
            a.action-link.delete:hover {
                color: #c0392b;
            }
            a.back-link {
                display: block;
                text-align: center;
                color: #2980b9;
                text-decoration: none;
                font-size: 14px;
                font-weight: 600;
            }
            a.back-link:hover {
                text-decoration: underline;
            }
            @media (max-width: 600px) {
                table, thead, tbody, th, td, tr {
                    display: block;
                }
                thead tr {
                    position: absolute;
                    top: -9999px;
                    left: -9999px;
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
                    position: relative;
                    padding-left: 50%;
                    text-align: left;
                    font-size: 14px;
                    white-space: normal;
                }
                td:before {
                    position: absolute;
                    top: 12px;
                    left: 18px;
                    width: 45%;
                    padding-right: 10px;
                    white-space: nowrap;
                    font-weight: 700;
                    color: #555;
                }
                td:nth-of-type(1):before {
                    content: "ID";
                }
                td:nth-of-type(2):before {
                    content: "Fruit Name";
                }
                td:nth-of-type(3):before {
                    content: "Origin";
                }
                td:nth-of-type(4):before {
                    content: "Actions";
                }
                a.action-link {
                    margin: 0 5px 0 0;
                    font-size: 13px;
                }
            }
        </style>
    </head>
    <body>
        <h2>List of Fruit Types</h2>
        <a href="<%=request.getContextPath()%>/fruit/add" class="add-btn">Add Fruit</a>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Fruit Name</th>
                    <th>Origin</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Fruit> list = (List<Fruit>) request.getAttribute("fruitList");
                    if (list != null && !list.isEmpty()) {
                        for (Fruit f : list) {
                %>
                <tr>
                    <td><%= f.getFruitId()%></td>
                    <td><%= f.getName()%></td>
                    <td><%= f.getSourceCountry()%></td>
                    <td>
                        <a href="<%=request.getContextPath()%>/fruit/edit?id=<%= f.getFruitId()%>" class="action-link">Edit</a>
                        <a href="<%=request.getContextPath()%>/fruit/delete?id=<%= f.getFruitId()%>" onclick="return confirm('Are you sure to delete?');" class="action-link delete">Delete</a>
                    </td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr><td colspan="4">No Information</td></tr>
                <% }%>
            </tbody>
        </table>

        <a href="<%=request.getContextPath()%>/dashboard.jsp" class="back-link">Back to Home Page</a>
    </body>
</html>