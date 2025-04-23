package it.ass.dao;

import it.ass.model.Reservation;
import it.ass.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {

    // 新增預約
    public boolean addReservation(Reservation r) {
        String sql = "INSERT INTO reservations (user_id, fruit_id, quantity, reserve_date, status) VALUES (?, ?, ?, ?, 'pending')";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, r.getUserId());
            ps.setInt(2, r.getFruitId());
            ps.setInt(3, r.getQuantity());
            ps.setDate(4, r.getReserveDate());
            return ps.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 取得某用戶所有預約紀錄
    public List<Reservation> getReservationsByUserId(int userId) {
        List<Reservation> list = new ArrayList<>();
        String sql = "SELECT * FROM reservations WHERE user_id=? ORDER BY reserve_date DESC";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Reservation r = new Reservation();
                    r.setReservationId(rs.getInt("reservation_id"));
                    r.setUserId(rs.getInt("user_id"));
                    r.setFruitId(rs.getInt("fruit_id"));
                    r.setQuantity(rs.getInt("quantity"));
                    r.setReserveDate(rs.getDate("reserve_date"));
                    r.setStatus(rs.getString("status"));
                    list.add(r);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
