/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package it.ass.controller;

import it.ass.dao.ShopDAO;
import it.ass.dao.UserDAO;
import it.ass.model.Shop;
import it.ass.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/user/edit")
public class UserEditServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        UserDAO userDAO = new UserDAO();
        ShopDAO shopDAO = new ShopDAO();

        User user = userDAO.getUserById(id);
        List<Shop> shopList = shopDAO.getAllShops();

        req.setAttribute("user", user);
        req.setAttribute("shopList", shopList);  // 傳所有店鋪給 JSP

        req.getRequestDispatcher("/user_edit.jsp").forward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("userId"));
        String username = req.getParameter("username");
        String role = req.getParameter("role");
        String city = req.getParameter("city");
        int shopId = 0;
        try {
            shopId = Integer.parseInt(req.getParameter("shopId"));
        } catch (NumberFormatException e) {
            // 可根據需求處理錯誤，如設定預設值或回傳錯誤訊息
        }

        User user = new User();
        user.setUserId(id);
        user.setUsername(username);
        user.setRole(role);
        user.setCity(city);
        user.setShopId(shopId);

        new UserDAO().updateUserWithShop(user);

        res.sendRedirect(req.getContextPath() + "/user/list");
    }
}
