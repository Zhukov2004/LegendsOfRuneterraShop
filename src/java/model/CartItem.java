package model;

public class CartItem {
    private String itemCode;
    private String itemName;
    private int price;
    private int quantity;
    private String itemType; // "card", "relic", "cardback"
    private String imagePath;

    public CartItem(String itemCode, String itemName, int price, int quantity, String itemType, String imagePath) {
        this.itemCode = itemCode;
        this.itemName = itemName;
        this.price = price;
        this.quantity = quantity;
        this.itemType = itemType;
        this.imagePath = imagePath;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }
    

    public void setItemCode(String itemCode) {
        this.itemCode = itemCode;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public void setItemType(String itemType) {
        this.itemType = itemType;
    }
    
    public String getItemCode() { return itemCode; }
    public String getItemName() { return itemName; }
    public int getPrice() { return price; }
    public int getQuantity() { return quantity; }
    public String getItemType() { return itemType; }
}

