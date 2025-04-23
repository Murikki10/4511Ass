package it.ass.dao;

import it.ass.model.Shop;
import it.ass.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ShopDAO {

    public List<Shop> getAllShops() {
        List<Shop> shopList = new ArrayList<>();
        String sql = "SELECT shop_id, shop_name, city, address FROM shop";

        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Shop shop = new Shop();
                shop.setShopId(rs.getInt("shop_id"));
                shop.setShopName(rs.getString("shop_name"));
                shop.setCity(rs.getString("city"));
                shop.setAddress(rs.getString("address"));
                shopList.add(shop);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return shopList;
    }

    public Shop getShopById(int shopId) {
    Shop shop = null;
    String sql = "SELECT * FROM shop WHERE shop_id = ?";
    try (Connection conn = DBUtil.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, shopId);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                shop = new Shop();
                shop.setShopId(rs.getInt("shop_id"));
                shop.setShopName(rs.getString("shop_name"));  // 假設欄位叫 shop_name
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return shop;
}

    public List<Shop> getShopsInCityExcept(String city, int excludeShopId) {
        List<Shop> list = new ArrayList<>();
        String sql = "SELECT * FROM shop WHERE city = ? AND shop_id <> ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, city);
            ps.setInt(2, excludeShopId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Shop s = new Shop();
                    s.setShopId(rs.getInt("shop_id"));
                    s.setShopName(rs.getString("shop_name"));
                    s.setCity(rs.getString("city"));
                    s.setAddress(rs.getString("address"));
                    list.add(s);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}
