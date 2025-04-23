package it.ass;

import it.ass.util.DBUtil;
import java.sql.Connection;

public class DBTest {
    public static void main(String[] args) {
        try (Connection conn = DBUtil.getConnection()) {
            if (conn != null) {
                System.out.println("SSSSSSS");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
