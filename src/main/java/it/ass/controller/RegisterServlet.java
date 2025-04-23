package it.ass.controller;

import it.ass.dao.UserDAO;
import it.ass.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String role = req.getParameter("role");
        String city = req.getParameter("city");
        String shopIdStr = req.getParameter("shopId");
        int shopId = 0;
        try {
            shopId = Integer.parseInt(shopIdStr);
        } catch (Exception e) {
            e.printStackTrace();
        }

        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setRole(role);
        user.setCity(city);
        user.setShopId(shopId);

        boolean success = new UserDAO().register(user);
        if (success) {
            res.sendRedirect("login.jsp");
        } else {
            req.setAttribute("error", "Register Failed");
            req.getRequestDispatcher("register.jsp").forward(req, res);
        }
    }
}
