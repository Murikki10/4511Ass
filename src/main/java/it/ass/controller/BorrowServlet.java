package it.ass.controller;

import it.ass.dao.BorrowRequestDAO;
import it.ass.dao.FruitDAO;
import it.ass.dao.ShopDAO;
import it.ass.model.BorrowRequest;
import it.ass.model.Fruit;
import it.ass.model.Shop;
import it.ass.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/borrow/*")
public class BorrowServlet extends HttpServlet {

    private final BorrowRequestDAO borrowRequestDAO = new BorrowRequestDAO();
    private final FruitDAO fruitDAO = new FruitDAO();
    private final ShopDAO shopDAO = new ShopDAO();

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

        Map<Integer, Shop> fromShopMap = new HashMap<>();
        Map<Integer, Fruit> fruitMap = new HashMap<>();

        for (BorrowRequest br : borrowList) {
            int fromShopId = br.getFromShopId();
            if (!fromShopMap.containsKey(fromShopId)) {
                Shop shop = shopDAO.getShopById(fromShopId);
                fromShopMap.put(fromShopId, shop);
            }

            int fruitId = br.getFruitId();
            if (!fruitMap.containsKey(fruitId)) {
                Fruit fruit = fruitDAO.getFruitById(fruitId);
                fruitMap.put(fruitId, fruit);
            }
        }

        req.setAttribute("borrowList", borrowList);
        req.setAttribute("fromShopMap", fromShopMap);
        req.setAttribute("fruitMap", fruitMap);
        req.getRequestDispatcher("/borrow_list.jsp").forward(req, resp);
    }

    private void showBorrowRequestForm(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        List<Fruit> fruits = fruitDAO.getAllFruits();
        // 取得同城市且排除自己店鋪的店鋪清單
        List<Shop> shopsInSameCity = shopDAO.getShopsInCityExcept(user.getCity(), user.getShopId());
        req.setAttribute("fruitList", fruits);
        req.setAttribute("shopsInSameCity", shopsInSameCity);
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
                List<Shop> shopsInSameCity = shopDAO.getShopsInCityExcept(user.getCity(), user.getShopId());
                boolean validFromShop = shopsInSameCity.stream().anyMatch(s -> s.getShopId() == fromShopId);

                if (!validFromShop) {
                    errorMsg = "借出店鋪必須是同一城市且不同店鋪";
                } else {
                    int availableStock = fruitDAO.getStockByShopIdAndFruitId(fromShopId, fruitId);
                    if (quantity > availableStock) {
                        errorMsg = "借用數量超過庫存，庫存剩餘：" + availableStock;
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
            }
        } catch (NumberFormatException e) {
            errorMsg = "請輸入有效的數字";
        }

        req.setAttribute("error", errorMsg);
        showBorrowRequestForm(req, resp, user);
    }
}
