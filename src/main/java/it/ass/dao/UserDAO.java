package it.ass.dao;

import it.ass.model.User;
import it.ass.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    public User login(String username, String password) {
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User u = new User();
                u.setUserId(rs.getInt("user_id"));
                u.setUsername(rs.getString("username"));
                u.setRole(rs.getString("role"));
                u.setCity(rs.getString("city"));
                return u;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean register(User user) {
        String sql = "INSERT INTO users (username, password, role, city) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            System.out.println("註冊參數：username=" + user.getUsername()
                    + ", password=" + user.getPassword()
                    + ", role=" + user.getRole()
                    + ", city=" + user.getCity());

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getRole());
            ps.setString(4, user.getCity());

            boolean inserted = ps.executeUpdate() == 1;
            System.out.println("註冊結果: " + inserted);
            return inserted;

        } catch (Exception e) {
            System.out.println("reg failed：" + e.getMessage());
            e.printStackTrace(); // 印出完整錯誤
        }
        return false;
    }

    // 取得所有用戶
    public List<User> getAllUsers() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM users";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User u = new User();
                u.setUserId(rs.getInt("user_id"));
                u.setUsername(rs.getString("username"));
                u.setRole(rs.getString("role"));
                u.setCity(rs.getString("city"));
                list.add(u);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

// 根據ID取得單一用戶
    public User getUserById(int id) {
        String sql = "SELECT * FROM users WHERE user_id=?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User u = new User();
                u.setUserId(rs.getInt("user_id"));
                u.setUsername(rs.getString("username"));
                u.setRole(rs.getString("role"));
                u.setCity(rs.getString("city"));
                return u;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

// 修改用戶
    public boolean updateUser(User user) {
        String sql = "UPDATE users SET username=?, role=?, city=? WHERE user_id=?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getRole());
            ps.setString(3, user.getCity());
            ps.setInt(4, user.getUserId());
            return ps.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

// 刪除用戶
    public boolean deleteUser(int id) {
        String sql = "DELETE FROM users WHERE user_id=?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
