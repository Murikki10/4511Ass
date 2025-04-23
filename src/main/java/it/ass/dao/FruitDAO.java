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
    public boolean updateStock(int stockId, int shopId, int fruitId, int quantity) {
        String sql = "UPDATE fruit_stock SET quantity = ? WHERE stock_id = ? AND shop_id = ? AND fruit_id = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, quantity);
            ps.setInt(2, stockId);
            ps.setInt(3, shopId);
            ps.setInt(4, fruitId);
            return ps.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 新增庫存
    public boolean addStock(int fruitId, int shopId, int quantity, String locationName) {
        String locationType = "shop";
        String sqlCheck = "SELECT * FROM fruit_stock WHERE shop_id = ? AND fruit_id = ?";
        String sqlInsert = "INSERT INTO fruit_stock (fruit_id, location_type, location_name, quantity, shop_id) VALUES (?, ?, ?, ?, ?)";
        String sqlUpdate = "UPDATE fruit_stock SET quantity = quantity + ? WHERE shop_id = ? AND fruit_id = ?";

        try (Connection conn = DBUtil.getConnection()) {
            try (PreparedStatement psCheck = conn.prepareStatement(sqlCheck)) {
                psCheck.setInt(1, shopId);
                psCheck.setInt(2, fruitId);
                try (ResultSet rs = psCheck.executeQuery()) {
                    if (rs.next()) {
                        try (PreparedStatement psUpdate = conn.prepareStatement(sqlUpdate)) {
                            psUpdate.setInt(1, quantity);
                            psUpdate.setInt(2, shopId);
                            psUpdate.setInt(3, fruitId);
                            return psUpdate.executeUpdate() == 1;
                        }
                    } else {
                        try (PreparedStatement psInsert = conn.prepareStatement(sqlInsert)) {
                            psInsert.setInt(1, fruitId);
                            psInsert.setString(2, locationType);
                            psInsert.setString(3, locationName);
                            psInsert.setInt(4, quantity);
                            psInsert.setInt(5, shopId);
                            return psInsert.executeUpdate() == 1;
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 查詢指定店鋪與水果的庫存數量（修正欄位名稱為 quantity）
    public int getStockByShopIdAndFruitId(int shopId, int fruitId) {
        String sql = "SELECT quantity FROM fruit_stock WHERE shop_id = ? AND fruit_id = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, shopId);
            ps.setInt(2, fruitId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("quantity");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;  // 無紀錄視為庫存 0
    }

    // 查詢指定店鋪與水果的庫存明細
    public List<FruitStock> getFruitStockDetailByShopIdAndFruitId(int shopId, int fruitId) {
        List<FruitStock> list = new ArrayList<>();
        String sql = "SELECT stock_id, shop_id, fruit_id, quantity, location_name FROM fruit_stock WHERE shop_id = ? AND fruit_id = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, shopId);
            ps.setInt(2, fruitId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    FruitStock fs = new FruitStock();
                    fs.setStockId(rs.getInt("stock_id"));
                    fs.setShopId(rs.getInt("shop_id"));
                    fs.setFruitId(rs.getInt("fruit_id"));
                    fs.setQuantity(rs.getInt("quantity"));
                    fs.setLocationName(rs.getString("location_name"));
                    list.add(fs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 查詢指定店鋪與水果的庫存明細
    public List<FruitStock> findStockDetailsByShopIdAndFruitId(int shopId, int fruitId) {
        List<FruitStock> list = new ArrayList<>();
        String sql = "SELECT stock_id, shop_id, fruit_id, quantity, location_name FROM fruit_stock WHERE shop_id = ? AND fruit_id = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, shopId);
            ps.setInt(2, fruitId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    FruitStock fs = new FruitStock();
                    fs.setStockId(rs.getInt("stock_id"));
                    fs.setShopId(rs.getInt("shop_id"));
                    fs.setFruitId(rs.getInt("fruit_id"));
                    fs.setQuantity(rs.getInt("quantity"));
                    fs.setLocationName(rs.getString("location_name"));
                    list.add(fs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 取得自己店鋪指定水果的庫存明細
    public List<FruitStock> getFruitStockDetailsByShopAndFruit(int shopId, int fruitId) {
        List<FruitStock> list = new ArrayList<>();
        String sql = "SELECT stock_id, shop_id, fruit_id, quantity, location_name FROM fruit_stock WHERE shop_id = ? AND fruit_id = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, shopId);
            ps.setInt(2, fruitId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    FruitStock fs = new FruitStock();
                    fs.setStockId(rs.getInt("stock_id"));
                    fs.setShopId(rs.getInt("shop_id"));
                    fs.setFruitId(rs.getInt("fruit_id"));
                    fs.setQuantity(rs.getInt("quantity"));
                    fs.setLocationName(rs.getString("location_name"));
                    list.add(fs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

// 取得整個地區指定水果的庫存明細（location_type='shop'，location_name為城市）
    public List<FruitStock> getFruitStockDetailsByCityAndFruit(String cityName, int fruitId) {
        List<FruitStock> list = new ArrayList<>();
        String sql = "SELECT stock_id, shop_id, fruit_id, quantity, location_name FROM fruit_stock WHERE fruit_id = ? AND location_name = ? AND location_type = 'shop'";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, fruitId);
            ps.setString(2, cityName);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    FruitStock fs = new FruitStock();
                    fs.setStockId(rs.getInt("stock_id"));
                    fs.setShopId(rs.getInt("shop_id"));
                    fs.setFruitId(rs.getInt("fruit_id"));
                    fs.setQuantity(rs.getInt("quantity"));
                    fs.setLocationName(rs.getString("location_name"));
                    list.add(fs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    // 取得自己店鋪所有水果庫存彙總

    public List<FruitStockSummary> getFruitStockSummaryByShop(int shopId) {
        List<FruitStockSummary> list = new ArrayList<>();
        String sql = "SELECT f.fruit_id, f.name, SUM(fs.quantity) AS total_quantity "
                + "FROM fruits f JOIN fruit_stock fs ON f.fruit_id = fs.fruit_id "
                + "WHERE fs.shop_id = ? AND fs.location_type = 'shop' "
                + "GROUP BY f.fruit_id, f.name";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, shopId);
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
}
