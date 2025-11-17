package model;

import java.util.List;

public class Card {
    private String cardCode;
    private String name;
    private String descriptionRaw;
    private String rarityRef;
    private String regionRefs;
    private int cost;
    private String type;
    private int price;

    public String getCardCode() {
        return cardCode;
    }

    public void setCardCode(String cardCode) {
        this.cardCode = cardCode;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescriptionRaw() {
        return descriptionRaw;
    }

    public void setDescriptionRaw(String descriptionRaw) {
        this.descriptionRaw = descriptionRaw;
    }

    public String getRarityRef() {
        return rarityRef;
    }

    public void setRarityRef(String rarityRef) {
        this.rarityRef = rarityRef;
    }

    public String getRegionRefs() {
        return regionRefs;
    }

    public void setRegionRefs(String regionRefs) {
        this.regionRefs = regionRefs;
    }

    public int getCost() {
        return cost;
    }

    public void setCost(int cost) {
        this.cost = cost;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }
    private boolean purchased;

public boolean isPurchased() {
    return purchased;
}

public void setPurchased(boolean purchased) {
    this.purchased = purchased;
}

    
}


