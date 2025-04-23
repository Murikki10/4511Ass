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

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

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
}