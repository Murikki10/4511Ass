package it.ass.controller;

import it.ass.dao.FruitDAO;
import it.ass.model.Fruit;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/fruit/*")
public class FruitServlet extends HttpServlet {
    private FruitDAO dao = new FruitDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String action = req.getPathInfo();
        if (action == null || "/list".equals(action)) {
            List<Fruit> list = dao.getAllFruits();
            req.setAttribute("fruitList", list);
            req.getRequestDispatcher("/fruit_list.jsp").forward(req, res);
        } else if ("/add".equals(action)) {
            req.getRequestDispatcher("/fruit_add.jsp").forward(req, res);
        } else if ("/edit".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            Fruit fruit = dao.getFruitById(id);
            req.setAttribute("fruit", fruit);
            req.getRequestDispatcher("/fruit_edit.jsp").forward(req, res);
        } else if ("/delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            dao.deleteFruit(id);
            res.sendRedirect(req.getContextPath() + "/fruit/list");
        } else {
            res.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getPathInfo();

        if ("/add".equals(action)) {
            String name = req.getParameter("name");
            String sourceCountry = req.getParameter("sourceCountry");
            Fruit fruit = new Fruit();
            fruit.setName(name);
            fruit.setSourceCountry(sourceCountry);
            dao.addFruit(fruit);
            res.sendRedirect(req.getContextPath() + "/fruit/list");
        } else if ("/edit".equals(action)) {
            int id = Integer.parseInt(req.getParameter("fruitId"));
            String name = req.getParameter("name");
            String sourceCountry = req.getParameter("sourceCountry");
            Fruit fruit = new Fruit();
            fruit.setFruitId(id);
            fruit.setName(name);
            fruit.setSourceCountry(sourceCountry);
            dao.updateFruit(fruit);
            res.sendRedirect(req.getContextPath() + "/fruit/list");
        } else {
            res.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}