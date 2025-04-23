<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List,it.ass.model.BorrowRequest,it.ass.dao.FruitDAO,it.ass.model.Fruit,it.ass.dao.UserDAO,it.ass.model.User" %>
<%
    List<BorrowRequest> borrowList = (List<BorrowRequest>)request.getAttribute("borrowList");
    FruitDAO fruitDAO = new FruitDAO();
    UserDAO userDAO = new UserDAO();
%>
<html>
    <head><title>借水果紀錄</title></head>
    <body>
        <h2>借水果紀錄</h2>
        <a href="<%=request.getContextPath()%>/borrow/add">新增借水果申請</a><br/><br/>
        <table border="1" cellpadding="5">
            <tr><th>ID</th><th>借出店鋪</th><th>水果</th><th>數量</th><th>申請日期</th><th>狀態</th></tr>
                    <%
                        if(borrowList != null && !borrowList.isEmpty()) {
                            for(BorrowRequest br : borrowList) {
                                User fromShop = userDAO.getUserByShopId(br.getFromShopId());
                                Fruit fruit = fruitDAO.getFruitById(br.getFruitId());
                    %>
            <tr>
                <td><%= br.getRequestId() %></td>
                <td><%= fromShop != null ? fromShop.getUsername() : "未知店鋪" %></td>
                <td><%= fruit != null ? fruit.getName() : "未知水果" %></td>
                <td><%= br.getQuantity() %></td>
                <td><%= br.getRequestDate() %></td>
                <td><%= br.getStatus() %></td>
            </tr>
            <%  }
        } else { %>
            <tr><td colspan="6">無借水果紀錄</td></tr>
            <% } %>
        </table>
        <a href="<%=request.getContextPath()%>/dashboard.jsp">回首頁</a>
    </body>
</html>