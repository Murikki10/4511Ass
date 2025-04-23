<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>水果庫存更新</title></head>
<body>
<h2>更新水果庫存</h2>
<form action="updateStock" method="post">
    水果ID: <input type="text" name="fruitId" required><br><br>
    新庫存數量: <input type="number" name="stock" min="0" required><br><br>
    <input type="submit" value="更新庫存">
</form>
</body>
</html>