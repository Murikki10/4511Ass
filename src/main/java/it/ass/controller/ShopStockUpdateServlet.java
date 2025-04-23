package it.ass.controller;

import it.ass.dao.FruitDAO;
import it.ass.model.FruitStock;
import it.ass.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import java.io.IOException;
import java.util.List;

@WebServlet("/shop/stockupdate")
public class ShopStockUpdateServlet extends HttpServlet {
    private FruitDAO dao = new FruitDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }
        String city = user.getCity();
        int fruitId = Integer.parseInt(req.getParameter("fruitId"));
        List<FruitStock> stockDetails = dao.getFruitStockByFruitIdAndCity(fruitId, city);
        req.setAttribute("stockDetails", stockDetails);
        req.getRequestDispatcher("/shop_stock_update.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int stockId = Integer.parseInt(req.getParameter("stockId"));
        int newQuantity = Integer.parseInt(req.getParameter("quantity"));
        boolean success = dao.updateStockQuantity(stockId, newQuantity);
        int fruitId = Integer.parseInt(req.getParameter("fruitId"));
        resp.sendRedirect(req.getContextPath() + "/shop/stockupdate?fruitId=" + fruitId);
    }
}