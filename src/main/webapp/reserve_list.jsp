<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List,it.ass.model.Reservation,it.ass.dao.FruitDAO,it.ass.model.Fruit" %>
<%
    List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservations");
    FruitDAO fruitDAO = new FruitDAO();
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>My Fruit Reservation Records</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f8fafc;
                margin: 20px;
                color: #333;
            }
            h2 {
                text-align: center;
                color: #2c3e50;
                margin-bottom: 25px;
            }
            a.add-appointment {
                display: inline-block;
                background-color: #3498db;
                color: white;
                padding: 10px 18px;
                border-radius: 5px;
                text-decoration: none;
                font-weight: 600;
                margin-bottom: 20px;
                transition: background-color 0.3s ease;
            }
            a.add-appointment:hover {
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
            a.back-link {
                display: block;
                text-align: center;
                color: #2980b9;
                font-weight: 600;
                text-decoration: none;
                font-size: 14px;
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
                    content: "Quantity";
                }
                td:nth-of-type(4):before {
                    content: "Appointment Date";
                }
                td:nth-of-type(5):before {
                    content: "Status";
                }
            }
        </style>
    </head>
    <body>
        <h2>My Fruit Reservation Records</h2>
        <a href="<%=request.getContextPath()%>/reserve/add" class="add-appointment">Add an Appointment</a>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Fruit Name</th>
                    <th>Quantity</th>
                    <th>Appointment Date</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (reservations != null && !reservations.isEmpty()) {
                        for (Reservation r : reservations) {
                            Fruit fruit = fruitDAO.getFruitById(r.getFruitId());
                %>
                <tr>
                    <td><%= r.getReservationId()%></td>
                    <td><%= fruit != null ? fruit.getName() : "Unknown"%></td>
                    <td><%= r.getQuantity()%></td>
                    <td><%= r.getReserveDate()%></td>
                    <td><%= r.getStatus()%></td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr><td colspan="5">No reservation record</td></tr>
                <% }%>
            </tbody>
        </table>

        <a href="<%=request.getContextPath()%>/dashboard.jsp" class="back-link">Back to Home Page</a>
    </body>
</html>