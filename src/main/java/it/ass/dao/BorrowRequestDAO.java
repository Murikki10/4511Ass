package it.ass.dao;

import it.ass.model.BorrowRequest;
import it.ass.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BorrowRequestDAO {

    /**
     * 新增借水果申請
     *
     * @param br BorrowRequest物件
     * @return 是否新增成功
     */
    public boolean addBorrowRequest(BorrowRequest br) {
        String sql = "INSERT INTO borrow_requests (from_shop_id, to_shop_id, fruit_id, quantity, status, request_date) VALUES (?, ?, ?, ?, 'pending', ?)";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, br.getFromShopId());
            ps.setInt(2, br.getToShopId());
            ps.setInt(3, br.getFruitId());
            ps.setInt(4, br.getQuantity());
            ps.setDate(5, br.getRequestDate());
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * 查詢指定店鋪所有借用請求
     *
     * @param toShopId 目標店鋪ID
     * @return BorrowRequest列表
     */
    public List<BorrowRequest> getBorrowRequestsByToShopId(int toShopId) {
        List<BorrowRequest> list = new ArrayList<>();
        String sql = "SELECT * FROM borrow_requests WHERE to_shop_id=? ORDER BY request_date DESC";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, toShopId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    BorrowRequest br = extractBorrowRequestFromResultSet(rs);
                    list.add(br);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * 更新借用請求狀態
     *
     * @param borrowId 申請ID
     * @param status 新狀態，例如 'approved', 'rejected', 'pending'
     * @return 是否更新成功
     */
    public boolean updateStatus(int borrowId, String status) {
        String sql = "UPDATE borrow_requests SET status=? WHERE borrow_id=?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, borrowId);
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * 輔助方法：從ResultSet抽取BorrowRequest物件
     */
    private BorrowRequest extractBorrowRequestFromResultSet(ResultSet rs) throws SQLException {
        BorrowRequest br = new BorrowRequest();
        br.setRequestId(rs.getInt("borrow_id"));  // 主鍵欄位改為 borrow_id
        br.setFromShopId(rs.getInt("from_shop_id"));
        br.setToShopId(rs.getInt("to_shop_id"));
        br.setFruitId(rs.getInt("fruit_id"));
        br.setQuantity(rs.getInt("quantity"));
        br.setStatus(rs.getString("status"));
        br.setRequestDate(rs.getDate("request_date"));
        return br;
    }
}
