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

@WebServlet("/user/list")
public class UserListServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        UserDAO userDAO = new UserDAO();
        ShopDAO shopDAO = new ShopDAO();

        List<User> users = userDAO.getAllUsers();

        // 對每個user查店舖名，放入request attribute方便JSP顯示
        for (User u : users) {
            Shop shop = shopDAO.getShopById(u.getShopId());
            if (shop != null) {
                req.setAttribute("shopName_" + u.getUserId(), shop.getShopName());
            } else {
                req.setAttribute("shopName_" + u.getUserId(), "N/A");
            }
        }

        req.setAttribute("userList", users);
        req.getRequestDispatcher("/user_list.jsp").forward(req, res);
    }
}