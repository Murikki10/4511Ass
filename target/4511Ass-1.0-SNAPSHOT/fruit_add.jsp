<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head><title>Add Fruit</title></head>
<body>
<h2>Add Fruit</h2>
<form method="post" action="<%=request.getContextPath()%>/fruit/add">
    Fruit name：<input type="text" name="name" required/><br/>
    Origin：<input type="text" name="sourceCountry" required/><br/>
    <button type="submit">Add</button>
</form>
<a href="<%=request.getContextPath()%>/fruit/list">Back to list</a>
</body>
</html>