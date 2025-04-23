package it.ass.controller;

import it.ass.dao.FruitDAO;
import it.ass.model.Fruit;
import it.ass.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/shop/stockadd")
public class ShopStockAddServlet extends HttpServlet {
    private FruitDAO dao = new FruitDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }
        List<Fruit> fruitList = dao.getAllFruits();
        req.setAttribute("fruitList", fruitList);

        // 傳給JSP用戶所在城市（locationName）
        req.setAttribute("locationName", user.getCity());

        req.getRequestDispatcher("/shop_stock_add.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        try {
            int fruitId = Integer.parseInt(req.getParameter("fruitId"));
            String locationName = req.getParameter("locationName");
            int quantity = Integer.parseInt(req.getParameter("quantity"));

            boolean success = dao.addStock(fruitId, locationName, quantity);
            if (success) {
                resp.sendRedirect(req.getContextPath() + "/shop/stocklist");
            } else {
                req.setAttribute("error", "新增庫存失敗");
                doGet(req, resp);
            }
        } catch (NumberFormatException e) {
            req.setAttribute("error", "請輸入有效數字");
            doGet(req, resp);
        }
    }
}