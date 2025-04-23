package it.ass.controller;

import it.ass.dao.BorrowRequestDAO;
import it.ass.dao.FruitDAO;
import it.ass.dao.UserDAO;
import it.ass.model.BorrowRequest;
import it.ass.model.Fruit;
import it.ass.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/borrow/*")
public class BorrowServlet extends HttpServlet {

    private final BorrowRequestDAO borrowRequestDAO = new BorrowRequestDAO();
    private final FruitDAO fruitDAO = new FruitDAO();
    private final UserDAO userDAO = new UserDAO();

    private boolean isShopUser(User user) {
        return user != null && "shop".equalsIgnoreCase(user.getRole());
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User currentUser = getLoggedInUser(req, resp);
        if (currentUser == null) {
            return;
        }

        if (!isShopUser(currentUser)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "只有店鋪員工可以使用借水果功能");
            return;
        }

        String path = req.getPathInfo();
        if (path == null || "/list".equals(path)) {
            showBorrowRequestList(req, resp, currentUser);
        } else if ("/add".equals(path)) {
            showBorrowRequestForm(req, resp, currentUser);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User currentUser = getLoggedInUser(req, resp);
        if (currentUser == null) {
            return;
        }

        if (!isShopUser(currentUser)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "只有店鋪員工可以使用借水果功能");
            return;
        }

        String path = req.getPathInfo();
        if ("/add".equals(path)) {
            processAddBorrowRequest(req, resp, currentUser);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private User getLoggedInUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return null;
        }
        return user;
    }

    private void showBorrowRequestList(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        List<BorrowRequest> borrowList = borrowRequestDAO.getBorrowRequestsByToShopId(user.getShopId());
        req.setAttribute("borrowList", borrowList);
        req.getRequestDispatcher("/borrow_list.jsp").forward(req, resp);
    }

    private void showBorrowRequestForm(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        List<Fruit> fruits = fruitDAO.getAllFruits();
        List<User> shopsInOtherCities = userDAO.getUsersExceptCity(user.getCity(), user.getShopId());
        req.setAttribute("fruitList", fruits);
        req.setAttribute("shopsInOtherCities", shopsInOtherCities);
        req.getRequestDispatcher("/borrow_add.jsp").forward(req, resp);
    }

    private void processAddBorrowRequest(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String errorMsg = null;

        try {
            int fromShopId = Integer.parseInt(req.getParameter("fromShopId"));
            int fruitId = Integer.parseInt(req.getParameter("fruitId"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));

            if (quantity <= 0) {
                errorMsg = "數量必須大於零";
            } else {
                List<User> shopsInOtherCities = userDAO.getUsersExceptCity(user.getCity(), user.getShopId());
                boolean validFromShop = shopsInOtherCities.stream().anyMatch(s -> s.getShopId() == fromShopId);

                if (!validFromShop) {
                    errorMsg = "借出店鋪必須是不同城市的其他店鋪";
                } else {
                    BorrowRequest borrowRequest = new BorrowRequest();
                    borrowRequest.setFromShopId(fromShopId);
                    borrowRequest.setToShopId(user.getShopId());
                    borrowRequest.setFruitId(fruitId);
                    borrowRequest.setQuantity(quantity);
                    borrowRequest.setStatus("pending");
                    borrowRequest.setRequestDate(Date.valueOf(LocalDate.now()));

                    boolean success = borrowRequestDAO.addBorrowRequest(borrowRequest);
                    if (success) {
                        resp.sendRedirect(req.getContextPath() + "/borrow/list");
                        return;
                    } else {
                        errorMsg = "新增借水果申請失敗，請稍後再試";
                    }
                }
            }
        } catch (NumberFormatException e) {
            errorMsg = "請輸入有效的數字";
        }

        req.setAttribute("error", errorMsg);
        showBorrowRequestForm(req, resp, user);
    }
}
