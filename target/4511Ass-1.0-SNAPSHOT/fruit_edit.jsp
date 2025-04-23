<%@ page contentType="text/html; charset=UTF-8" %>
<%
    it.ass.model.Fruit fruit = (it.ass.model.Fruit)request.getAttribute("fruit");
%>
<html>
<head><title>Edit Fruit</title></head>
<body>
<h2>Edit Fruit</h2>
<form method="post" action="<%=request.getContextPath()%>/fruit/edit">
    <input type="hidden" name="fruitId" value="<%= fruit.getFruitId() %>"/>
    Fruit Name：<input type="text" name="name" value="<%= fruit.getName() %>" required/><br/>
    Origin：<input type="text" name="sourceCountry" value="<%= fruit.getSourceCountry() %>" required/><br/>
    <button type="submit">Update</button>
</form>
<a href="<%=request.getContextPath()%>/fruit/list">Back to list</a>
</body>
</html>