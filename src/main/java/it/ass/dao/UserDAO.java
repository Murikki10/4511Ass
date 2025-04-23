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
                // 新增設定 shopId
                u.setShopId(rs.getInt("shop_id"));
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
            System.out.println("註冊錯誤：" + e.getMessage());
            e.printStackTrace();
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
                u.setShopId(rs.getInt("shop_id"));  // 保持這行
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
                u.setShopId(rs.getInt("shop_id"));  // 加入這行，保持一致
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

    // 取得同城市其他店鋪（不包含自己店鋪）
    public List<User> getUserByShopId(String city, int excludeShopId) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE city = ? AND shop_id <> ? AND role='shop'";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, city);
            ps.setInt(2, excludeShopId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    User u = new User();
                    u.setUserId(rs.getInt("user_id"));
                    u.setUsername(rs.getString("username"));
                    u.setShopId(rs.getInt("shop_id"));
                    u.setCity(rs.getString("city"));
                    u.setRole(rs.getString("role"));
                    list.add(u);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public User getUserByShopId(int shopId) {
        User user = null;
        String sql = "SELECT * FROM users WHERE shop_id = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, shopId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setUserId(rs.getInt("user_id"));
                    user.setUsername(rs.getString("username"));
                    user.setShopId(rs.getInt("shop_id"));
                    user.setCity(rs.getString("city"));
                    user.setRole(rs.getString("role"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public List<User> getUsersExceptCity(String city, int excludeShopId) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE city <> ? AND shop_id <> ? AND role = 'shop'";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, city);
            ps.setInt(2, excludeShopId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    User u = new User();
                    u.setShopId(rs.getInt("shop_id"));
                    u.setUsername(rs.getString("username"));
                    u.setCity(rs.getString("city"));
                    u.setRole(rs.getString("role"));
                    list.add(u);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateUserWithShop(User user) {
        String sql = "UPDATE users SET username=?, role=?, city=?, shop_id=? WHERE user_id=?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getRole());
            ps.setString(3, user.getCity());
            ps.setInt(4, user.getShopId());
            ps.setInt(5, user.getUserId());
            return ps.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
