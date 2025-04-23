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

@WebServlet("/user/edit")
public class UserEditServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        User user = new UserDAO().getUserById(id);
        req.setAttribute("user", user);
        req.getRequestDispatcher("/user_edit.jsp").forward(req, res);
    }
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("userId"));
        String username = req.getParameter("username");
        String role = req.getParameter("role");
        String city = req.getParameter("city");
        User user = new User();
        user.setUserId(id);
        user.setUsername(username);
        user.setRole(role);
        user.setCity(city);
        new UserDAO().updateUser(user);
        res.sendRedirect(req.getContextPath()+"/user/list");
    }
}