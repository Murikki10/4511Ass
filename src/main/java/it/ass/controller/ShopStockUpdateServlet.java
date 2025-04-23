package it.ass.controller;

import it.ass.dao.FruitDAO;
import it.ass.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/shop/stockupdate")
public class ShopStockUpdateServlet extends HttpServlet {
    private FruitDAO dao = new FruitDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 讀取庫存明細，傳給更新頁面
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        int fruitId = 0;
        try {
            fruitId = Integer.parseInt(req.getParameter("fruitId"));
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/shop/stocklist");
            return;
        }

        int shopId = user.getShopId();

        // 取該店鋪該水果庫存明細
        req.setAttribute("stockDetails", dao.getFruitStockDetailByShopIdAndFruitId(shopId, fruitId));
        req.getRequestDispatcher("/shop_stock_update.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        try {
            int shopId = user.getShopId();
            int stockId = Integer.parseInt(req.getParameter("stockId"));
            int fruitId = Integer.parseInt(req.getParameter("fruitId"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));

            boolean success = dao.updateStock(stockId, shopId, fruitId, quantity);

            if (success) {
                resp.sendRedirect(req.getContextPath() + "/shop/stocklist");
            } else {
                req.setAttribute("error", "更新庫存失敗");
                doGet(req, resp);
            }
        } catch (NumberFormatException e) {
            req.setAttribute("error", "請輸入有效數字");
            doGet(req, resp);
        }
    }
}