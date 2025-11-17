package model;

import java.sql.Timestamp;

public class Purchase {
    private String username;
    private String itemName;
    private int price;
    private Timestamp time;
private String cardCode;
private String relicCode;

    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }

    public String getItemName() {
        return itemName;
    }
    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public int getPrice() {
        return price;
    }
    public void setPrice(int price) {
        this.price = price;
    }

    public Timestamp getTime() {
        return time;
    }
    public void setTime(Timestamp time) {
        this.time = time;
    }
    public String getCardCode() {
    return cardCode;
}
public void setCardCode(String cardCode) {
    this.cardCode = cardCode;
}

public String getRelicCode() {
    return relicCode;
}
public void setRelicCode(String relicCode) {
    this.relicCode = relicCode;
}

}
