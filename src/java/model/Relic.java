package model;

public class Relic {
    private String relicCode;
    private String name;
    private String rarity;
    private int price;
    private String descriptionRaw;
    private boolean purchased; // ✅ thêm flag đã mua

    public String getRelicCode() { return relicCode; }
    public void setRelicCode(String relicCode) { this.relicCode = relicCode; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getRarity() { return rarity; }
    public void setRarity(String rarity) { this.rarity = rarity; }

    public int getPrice() { return price; }
    public void setPrice(int price) { this.price = price; }

    public String getDescriptionRaw() { return descriptionRaw; }
    public void setDescriptionRaw(String descriptionRaw) { this.descriptionRaw = descriptionRaw; }

    public boolean isPurchased() { return purchased; }
    public void setPurchased(boolean purchased) { this.purchased = purchased; }
}
