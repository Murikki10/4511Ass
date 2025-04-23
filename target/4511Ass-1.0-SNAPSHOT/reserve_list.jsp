<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List,it.ass.model.Reservation,it.ass.dao.FruitDAO,it.ass.model.Fruit" %>
<%
    List<Reservation> reservations = (List<Reservation>)request.getAttribute("reservations");
    FruitDAO fruitDAO = new FruitDAO();
%>
<html>
<head><title>My fruit reservation record</title></head>
<body>
<h2>My fruit reservation record</h2>
<a href="<%=request.getContextPath()%>/reserve/add">Add an appointment</a><br/><br/>
<table border="1" cellpadding="5">
    <tr><th>ID</th><th>Fruit Name</th><th>quantity</th><th>Appointment Date</th><th>state</th></tr>
    <%
    if (reservations != null && !reservations.isEmpty()) {
        for (Reservation r : reservations) {
            Fruit fruit = fruitDAO.getFruitById(r.getFruitId());
    %>
    <tr>
        <td><%= r.getReservationId() %></td>
        <td><%= fruit != null ? fruit.getName() : "未知" %></td>
        <td><%= r.getQuantity() %></td>
        <td><%= r.getReserveDate() %></td>
        <td><%= r.getStatus() %></td>
    </tr>
    <%
        }
    } else {
    %>
    <tr><td colspan="5">No reservation record</td></tr>
    <% } %>
</table>
<a href="<%=request.getContextPath()%>/dashboard.jsp">Back To Home page</a>
</body>
</html>