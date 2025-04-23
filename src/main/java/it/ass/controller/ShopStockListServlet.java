package it.ass.controller;

import it.ass.dao.FruitDAO;
import it.ass.model.FruitStockSummary;
import it.ass.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/shop/stocklist")
public class ShopStockListServlet extends HttpServlet {

    private FruitDAO dao = new FruitDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String city = user.getCity();
        int shopId = user.getShopId();

        List<FruitStockSummary> cityStockList = dao.getFruitStockSummaryByCity(city);
        List<FruitStockSummary> myShopStockList = dao.getFruitStockSummaryByShop(shopId);

        req.setAttribute("cityStockList", cityStockList);
        req.setAttribute("myShopStockList", myShopStockList);

        req.getRequestDispatcher("/shop_stock_list.jsp").forward(req, resp);
    }
}
