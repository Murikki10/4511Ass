<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, it.ass.model.*" %>
<%
    List<BorrowRequest> borrowList = (List<BorrowRequest>) request.getAttribute("borrowList");
    Map<Integer, Shop> fromShopMap = (Map<Integer, Shop>) request.getAttribute("fromShopMap");
    Map<Integer, Fruit> fruitMap = (Map<Integer, Fruit>) request.getAttribute("fruitMap");
%>
<!DOCTYPE html>
<html lang="zh-Hant">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>借水果紀錄</title>
        <style>
            body {
                font-family: "Microsoft JhengHei", Arial, sans-serif;
                background-color: #f9f9f9;
                margin: 20px;
                color: #333;
            }
            h2 {
                color: #2c3e50;
                margin-bottom: 20px;
            }
            a.button {
                display: inline-block;
                background-color: #3498db;
                color: white;
                text-decoration: none;
                padding: 8px 16px;
                border-radius: 4px;
                margin-bottom: 20px;
                transition: background-color 0.3s ease;
            }
            a.button:hover {
                background-color: #2980b9;
            }
            table {
                width: 100%;
                max-width: 960px;
                border-collapse: collapse;
                margin-bottom: 40px;
                box-shadow: 0 0 8px rgba(0,0,0,0.1);
                background-color: white;
            }
            th, td {
                padding: 12px 15px;
                border: 1px solid #ddd;
                text-align: center;
                font-size: 14px;
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
            .status-pending {
                color: #e67e22;
                font-weight: bold;
            }
            .status-approved {
                color: #27ae60;
                font-weight: bold;
            }
            .status-rejected {
                color: #c0392b;
                font-weight: bold;
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
                    border: 1px solid #ccc;
                    margin-bottom: 15px;
                }
                td {
                    border: none;
                    border-bottom: 1px solid #eee;
                    position: relative;
                    padding-left: 50%;
                    text-align: left;
                    font-size: 13px;
                }
                td:before {
                    position: absolute;
                    top: 12px;
                    left: 15px;
                    width: 45%;
                    padding-right: 10px;
                    white-space: nowrap;
                    font-weight: bold;
                    color: #555;
                }
                td:nth-of-type(1):before {
                    content: "ID";
                }
                td:nth-of-type(2):before {
                    content: "Lend shop";
                }
                td:nth-of-type(3):before {
                    content: "fruit";
                }
                td:nth-of-type(4):before {
                    content: "quantity";
                }
                td:nth-of-type(5):before {
                    content: "Application Date";
                }
                td:nth-of-type(6):before {
                    content: "state";
                }
            }
        </style>
    </head>
    <body>
        <h2>Borrowing Fruit Records</h2>
        <a href="<%=request.getContextPath()%>/borrow/add" class="button">Added fruit borrowing application</a>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Lend shop</th>
                    <th>fruit</th>
                    <th>quantity</th>
                    <th>Application Date</th>
                    <th>state</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (borrowList == null || borrowList.isEmpty()) {
                %>
                <tr><td colspan="6">No record of borrowing fruit</td></tr>
                <%
                } else {
                    for (BorrowRequest br : borrowList) {
                        Shop fromShop = fromShopMap.get(br.getFromShopId());
                        String fromShopName = (fromShop != null) ? fromShop.getShopName() : "未知店鋪";

                        Fruit fruit = fruitMap.get(br.getFruitId());
                        String fruitName = (fruit != null) ? fruit.getName() : ("水果ID:" + br.getFruitId());

                        String statusClass = "";
                        if ("pending".equalsIgnoreCase(br.getStatus()))
                            statusClass = "status-pending";
                        else if ("approved".equalsIgnoreCase(br.getStatus()))
                            statusClass = "status-approved";
                        else if ("rejected".equalsIgnoreCase(br.getStatus()))
                            statusClass = "status-rejected";
                %>
                <tr>
                    <td><%= br.getRequestId()%></td>
                    <td><%= fromShopName%></td>
                    <td><%= fruitName%></td>
                    <td><%= br.getQuantity()%></td>
                    <td><%= br.getRequestDate()%></td>
                    <td class="<%= statusClass%>"><%= br.getStatus()%></td>
                </tr>
                <%  }
                    }
                %>
            </tbody>
        </table>

        <a href="<%=request.getContextPath()%>/dashboard.jsp" class="button" style="background-color:#7f8c8d;">Back to Home</a>
    </body>
</html>