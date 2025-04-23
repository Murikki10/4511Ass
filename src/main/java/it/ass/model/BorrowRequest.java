package it.ass.model;

import java.sql.Date;

public class BorrowRequest {
    private int requestId;
    private int fromShopId;  // 借出店鋪
    private int toShopId;    // 借入店鋪（申請人店鋪）
    private int fruitId;
    private int quantity;
    private String status;   // pending, approved, rejected
    private Date requestDate;

    // Getters & Setters
    public int getRequestId() {
        return requestId;
    }
    public void setRequestId(int requestId) {
        this.requestId = requestId;
    }
    public int getFromShopId() {
        return fromShopId;
    }
    public void setFromShopId(int fromShopId) {
        this.fromShopId = fromShopId;
    }
    public int getToShopId() {
        return toShopId;
    }
    public void setToShopId(int toShopId) {
        this.toShopId = toShopId;
    }
    public int getFruitId() {
        return fruitId;
    }
    public void setFruitId(int fruitId) {
        this.fruitId = fruitId;
    }
    public int getQuantity() {
        return quantity;
    }
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
    public Date getRequestDate() {
        return requestDate;
    }
    public void setRequestDate(Date requestDate) {
        this.requestDate = requestDate;
    }
}