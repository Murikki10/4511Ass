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

        int fruitId;
        try {
            fruitId = Integer.parseInt(req.getParameter("fruitId"));
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/shop/stocklist");
            return;
        }

        int shopId = user.getShopId();
        List<FruitStock> stockDetails = dao.findStockDetailsByShopIdAndFruitId(shopId, fruitId);

        req.setAttribute("stockDetails", stockDetails);
        req.getRequestDispatcher("/shop_stock_update.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        int shopId = user.getShopId();
        String[] stockIds = req.getParameterValues("stockId");
        String[] fruitIds = req.getParameterValues("fruitId");
        String[] quantities = req.getParameterValues("quantity");

        boolean allSuccess = true;
        try {
            for (int i = 0; i < stockIds.length; i++) {
                int stockId = Integer.parseInt(stockIds[i]);
                int fruitId = Integer.parseInt(fruitIds[i]);
                int quantity = Integer.parseInt(quantities[i]);

                boolean success = dao.updateStock(stockId, shopId, fruitId, quantity);
                if (!success) {
                    allSuccess = false;
                    break;
                }
            }
        } catch (Exception e) {
            allSuccess = false;
            e.printStackTrace();
        }

        if (allSuccess) {
            resp.sendRedirect(req.getContextPath() + "/shop/stocklist");
        } else {
            req.setAttribute("error", "Failed to update stock.");
            doGet(req, resp);
        }
    }
}
