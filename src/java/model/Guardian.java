/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class Guardian {
    private int id;              // id tự tăng trong DB
    private String name;         // tên hiển thị
    private String rarity;       // độ hiếm (Common, Rare, Epic…)
    private String description;  // mô tả chi tiết
    private int price;           // giá Xu
    private String imagePath;
    // Constructor rỗng
    public Guardian() {}

    public Guardian(int id, String name, String rarity, String description, int price, String imagePath) {
        this.id = id;
        this.name = name;
        this.rarity = rarity;
        this.description = description;
        this.price = price;
        this.imagePath = imagePath;
    }

    

    // Getter & Setter
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }


    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    public String getRarity() {
        return rarity;
    }
    public void setRarity(String rarity) {
        this.rarity = rarity;
    }

    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }

    public int getPrice() {
        return price;
    }
    public void setPrice(int price) {
        this.price = price;
    }
    public String getImagePath() {
        // Ví dụ: name = "Little Legend" → LoR_Little_Legend_Guardian.png
        return imagePath;
    }
}

