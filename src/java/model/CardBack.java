/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class CardBack {
    private String code;
    private String image;
    private String rarity;
    private String description;
    private int price;
    private boolean purchased;
    public CardBack(String code, String image, String rarity, String description, int price) {
        this.code = code;
        this.image = image;
        this.rarity = rarity;
        this.description = description;
        this.price = price;
        this.purchased = false;
    }

    public String getCode() { return code; }
    public String getImage() { return image; }
    public String getRarity() { return rarity; }
    public String getDescription() { return description; }
    public int getPrice() { return price; }
    public boolean isPurchased() { return purchased; }
    public void setPurchased(boolean purchased) { this.purchased = purchased; }
}
