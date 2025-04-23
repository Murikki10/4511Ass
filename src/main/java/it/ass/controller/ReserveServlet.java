package it.ass.controller;

import it.ass.dao.ReservationDAO;
import it.ass.dao.FruitDAO;
import it.ass.model.Reservation;
import it.ass.model.Fruit;
import it.ass.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/reserve/*")
public class ReserveServlet extends HttpServlet {
    private ReservationDAO reservationDAO = new ReservationDAO();
    private FruitDAO fruitDAO = new FruitDAO();

    private boolean isShopRole(User user) {
        return user != null && "shop".equalsIgnoreCase(user.getRole());
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");

        if (user == null) {
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        if (!isShopRole(user)) {
            res.sendError(HttpServletResponse.SC_FORBIDDEN, "Only store staff can use the reservation function");
            return;
        }

        String action = req.getPathInfo();

        if (action == null || "/list".equals(action)) {
            List<Reservation> reservations = reservationDAO.getReservationsByUserId(user.getUserId());
            req.setAttribute("reservations", reservations);
            req.getRequestDispatcher("/reserve_list.jsp").forward(req, res);
        } else if ("/add".equals(action)) {
            List<Fruit> fruits = fruitDAO.getAllFruits();
            req.setAttribute("fruitList", fruits);
            req.getRequestDispatcher("/reserve_add.jsp").forward(req, res);
        } else {
            res.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");

        if (user == null) {
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        if (!isShopRole(user)) {
            res.sendError(HttpServletResponse.SC_FORBIDDEN, "Only store staff can use the reservation function");
            return;
        }

        String action = req.getPathInfo();

        if ("/add".equals(action)) {
            req.setCharacterEncoding("UTF-8");
            int fruitId = Integer.parseInt(req.getParameter("fruitId"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            Date reserveDate = Date.valueOf(req.getParameter("reserveDate"));

            LocalDate today = LocalDate.now();
            LocalDate limitDate = today.plusDays(14);
            if (reserveDate.toLocalDate().isBefore(today) || reserveDate.toLocalDate().isAfter(limitDate)) {
                req.setAttribute("error", "The appointment date must be within the next 14 days");
                doGet(req, res);
                return;
            }

            Reservation r = new Reservation();
            r.setUserId(user.getUserId());
            r.setFruitId(fruitId);
            r.setQuantity(quantity);
            r.setReserveDate(reserveDate);

            boolean success = reservationDAO.addReservation(r);

            if (success) {
                res.sendRedirect(req.getContextPath() + "/reserve/list");
            } else {
                req.setAttribute("error", "Adding a new appointment failed");
                doGet(req, res);
            }
        } else {
            res.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}