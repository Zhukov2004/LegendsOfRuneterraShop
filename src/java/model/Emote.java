package model;

public class Emote {
    private int id;
    private String name;
    private String icon;
    private String rarity;
    private String description;
    private int price;

    // Constructor mặc định
    public Emote() {}

    // Constructor đầy đủ
    public Emote(int id, String name, String icon, String rarity, String description, int price) {
        this.id = id;
        this.name = name;
        this.icon = icon;
        this.rarity = rarity;
        this.description = description;
        this.price = price;
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

    public String getIcon() {
        return icon;
    }
    public void setIcon(String icon) {
        this.icon = icon;
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

}
