package it.ass.model;

import java.sql.Date;

public class Reservation {
    private int reservationId;
    private int userId;
    private int fruitId;
    private int quantity;
    private Date reserveDate;
    private String status; // pending, approved, rejected

    // Getters & Setters
    public int getReservationId() {
        return reservationId;
    }
    public void setReservationId(int reservationId) {
        this.reservationId = reservationId;
    }
    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {
        this.userId = userId;
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
    public Date getReserveDate() {
        return reserveDate;
    }
    public void setReserveDate(Date reserveDate) {
        this.reserveDate = reserveDate;
    }
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
}