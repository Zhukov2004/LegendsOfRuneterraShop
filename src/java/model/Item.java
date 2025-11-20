/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class Item {
    private String code;       // mã định danh (cardCode, relicCode, cardBackCode)
    private String name;       // tên hiển thị
    private String imagePath;
    private int price;
    private String type;

    public Item(String code, String name, String imagePath, int price, String type) {
        this.code = code;
        this.name = name;
        this.imagePath = imagePath;
        this.price = price;
        this.type = type;
    }

    public String getCode() { return code; }
    public String getName() { return name; }
    public String getImagePath() { return imagePath; }
    public int getPrice() { return price; }
    public String getType() { return type; }
}
