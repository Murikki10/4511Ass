package it.ass.model;

public class Fruit {
    private int fruitId;
    private String name;
    private String sourceCountry;
    private int stock;  // 新增庫存欄位

    // Getter & Setter
    public int getFruitId() {
        return fruitId;
    }
    public void setFruitId(int fruitId) {
        this.fruitId = fruitId;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getSourceCountry() {
        return sourceCountry;
    }
    public void setSourceCountry(String sourceCountry) {
        this.sourceCountry = sourceCountry;
    }
    public int getStock() {            // 新增 getter
        return stock;
    }
    public void setStock(int stock) {  // 新增 setter
        this.stock = stock;
    }
}