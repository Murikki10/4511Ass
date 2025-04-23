/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package it.ass.controller;

import it.ass.dao.UserDAO;
import it.ass.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        UserDAO dao = new UserDAO();
        User user = dao.login(username, password);

        if (user != null) {
            req.getSession().setAttribute("user", user);
            res.sendRedirect("dashboard.jsp");
        } else {
            req.setAttribute("error", "Login Failed！");
            req.getRequestDispatcher("login.jsp").forward(req, res);
        }
    }
}
