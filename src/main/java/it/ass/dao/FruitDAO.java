package it.ass.dao;

import it.ass.model.Fruit;
import it.ass.model.FruitStock;
import it.ass.model.FruitStockSummary;
import it.ass.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FruitDAO {

    public List<Fruit> getAllFruits() {
        List<Fruit> list = new ArrayList<>();
        String sql = "SELECT * FROM fruits";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Fruit f = new Fruit();
                f.setFruitId(rs.getInt("fruit_id"));
                f.setName(rs.getString("name"));
                f.setSourceCountry(rs.getString("source_country"));

                list.add(f);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Fruit getFruitById(int id) {
        String sql = "SELECT * FROM fruits WHERE fruit_id=?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Fruit f = new Fruit();
                    f.setFruitId(rs.getInt("fruit_id"));
                    f.setName(rs.getString("name"));
                    f.setSourceCountry(rs.getString("source_country"));
                    return f;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addFruit(Fruit fruit) {
        String sql = "INSERT INTO fruits (name, source_country) VALUES (?, ?)";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, fruit.getName());
            ps.setString(2, fruit.getSourceCountry());
            return ps.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateFruit(Fruit fruit) {
        String sql = "UPDATE fruits SET name=?, source_country=? WHERE fruit_id=?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, fruit.getName());
            ps.setString(2, fruit.getSourceCountry());
            ps.setInt(3, fruit.getFruitId());
            return ps.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteFruit(int id) {
        String sql = "DELETE FROM fruits WHERE fruit_id=?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 取得該城市所有水果種類及庫存總數
    public List<FruitStockSummary> getFruitStockSummaryByCity(String cityName) {
        List<FruitStockSummary> list = new ArrayList<>();
        String sql = "SELECT f.fruit_id, f.name, SUM(fs.quantity) AS total_quantity "
                + "FROM fruits f JOIN fruit_stock fs ON f.fruit_id = fs.fruit_id "
                + "WHERE fs.location_name = ? AND fs.location_type = 'shop' "
                + "GROUP BY f.fruit_id, f.name";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, cityName);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    FruitStockSummary summary = new FruitStockSummary();
                    summary.setFruitId(rs.getInt("fruit_id"));
                    summary.setFruitName(rs.getString("name"));
                    summary.setTotalQuantity(rs.getInt("total_quantity"));
                    list.add(summary);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 取得指定水果在該城市所有庫存明細
    public List<FruitStock> getFruitStockByFruitIdAndCity(int fruitId, String cityName) {
        List<FruitStock> list = new ArrayList<>();
        String sql = "SELECT * FROM fruit_stock WHERE fruit_id = ? AND location_name = ? AND location_type = 'shop'";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, fruitId);
            ps.setString(2, cityName);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    FruitStock fs = new FruitStock();
                    fs.setStockId(rs.getInt("stock_id"));
                    fs.setFruitId(rs.getInt("fruit_id"));
                    fs.setLocationType(rs.getString("location_type"));
                    fs.setLocationName(rs.getString("location_name"));
                    fs.setQuantity(rs.getInt("quantity"));
                    list.add(fs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 更新庫存數量
    public boolean updateStockQuantity(int stockId, int newQuantity) {
        if (newQuantity < 0) {
            return false;
        }
        String sql = "UPDATE fruit_stock SET quantity = ? WHERE stock_id = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, newQuantity);
            ps.setInt(2, stockId);
            return ps.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    // 新增庫存
    public boolean addStock(int fruitId, String locationName, int quantity) {
        if (quantity < 0) return false;
        String sql = "INSERT INTO fruit_stock (fruit_id, location_type, location_name, quantity) VALUES (?, 'shop', ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, fruitId);
            ps.setString(2, locationName);
            ps.setInt(3, quantity);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
}
