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
        req.setAttribute("locationName", user.getCity()); // 顯示城市名稱（readonly）
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
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            int shopId = user.getShopId(); // 用當前登入用戶店鋪ID
            String locationName = user.getCity(); // 用當前登入用戶城市作為location_name

            boolean success = dao.addStock(fruitId, shopId, quantity, locationName);
            if (success) {
                resp.sendRedirect(req.getContextPath() + "/shop/stocklist");
            } else {
                req.setAttribute("error", "Failed to add stock");
                doGet(req, resp);
            }
        } catch (NumberFormatException e) {
            req.setAttribute("error", "Invalid number format");
            doGet(req, resp);
        }
    }
}
