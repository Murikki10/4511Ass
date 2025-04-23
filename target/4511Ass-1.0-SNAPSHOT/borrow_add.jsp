<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List,it.ass.model.Fruit,it.ass.model.Shop" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    List<Fruit> fruitList = (List<Fruit>) request.getAttribute("fruitList");
    List<Shop> shopsInSameCity = (List<Shop>) request.getAttribute("shopsInSameCity");
%>
<!DOCTYPE html>
<html lang="zh-Hant">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>新增借水果申請</title>
        <style>
            body {
                font-family: "Microsoft JhengHei", Arial, sans-serif;
                background-color: #f9f9f9;
                margin: 20px;
                color: #333;
            }
            h2 {
                color: #2c3e50;
                margin-bottom: 25px;
            }
            form {
                background-color: white;
                max-width: 480px;
                padding: 25px 30px;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            }
            label {
                display: block;
                font-weight: 600;
                margin-bottom: 6px;
                margin-top: 15px;
                color: #34495e;
            }
            select, input[type="number"] {
                width: 100%;
                padding: 8px 10px;
                font-size: 15px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
                transition: border-color 0.3s ease;
            }
            select:focus, input[type="number"]:focus {
                border-color: #2980b9;
                outline: none;
            }
            button {
                margin-top: 25px;
                background-color: #3498db;
                color: white;
                font-weight: bold;
                padding: 12px 20px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
                width: 100%;
                transition: background-color 0.3s ease;
            }
            button:hover {
                background-color: #2980b9;
            }
            .error-message {
                color: #e74c3c;
                font-weight: 600;
                margin-bottom: 15px;
            }
            a.back-link {
                display: inline-block;
                margin-top: 20px;
                color: #2980b9;
                text-decoration: none;
                font-size: 14px;
            }
            a.back-link:hover {
                text-decoration: underline;
            }

            @media (max-width: 520px) {
                body {
                    margin: 10px;
                }
                form {
                    padding: 20px;
                }
            }
        </style>
    </head>
    <body>
        <h2>Added fruit borrowing application</h2>

        <c:if test="${not empty error}">
            <p class="error-message">${error}</p>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/borrow/add">
            <label for="fromShopId">Lend shop：</label>
            <select name="fromShopId" id="fromShopId" required>
                <option value="">--Please select the store you are lending from--</option>
                <c:forEach items="${shopsInSameCity}" var="shop">
                    <option value="${shop.shopId}" <c:if test="${param.fromShopId == shop.shopId}">selected</c:if>>
                        <c:out value="${shop.shopName}" />
                    </option>
                </c:forEach>
            </select>

            <label for="fruitId">fruit：</label>
            <select name="fruitId" id="fruitId" required>
                <option value="">--Please select fruit--</option>
                <c:forEach items="${fruitList}" var="fruit">
                    <option value="${fruit.fruitId}" <c:if test="${param.fruitId == fruit.fruitId}">selected</c:if>>
                        <c:out value="${fruit.name}" /> (source：<c:out value="${fruit.sourceCountry}" />)
                    </option>
                </c:forEach>
            </select>

            <label for="quantity">quantity：</label>
            <input type="number" name="quantity" id="quantity" min="1" required value="${param.quantity != null ? param.quantity : ''}" />

            <button type="submit">Apply for borrowing</button>
        </form>

        <a href="${pageContext.request.contextPath}/borrow/list" class="back-link">Back to borrow record</a>
    </body>
</html>