package model;

public class Board {
    private int id;                // id tự tăng
    private String name;           // tên bàn đấu
    private String icon;           // link icon
    private String display;        // link ảnh hiển thị
    private String loadingScreen;  // link màn hình loading
    private String rarity;         // độ hiếm (Common, Rare, Epic...)
    private String description;    // mô tả
    private int price;             // giá

    public Board(int id, String name, String icon, String display, String loadingScreen, String rarity, String description, int price) {
        this.id = id;
        this.name = name;
        this.icon = icon;
        this.display = display;
        this.loadingScreen = loadingScreen;
        this.rarity = rarity;
        this.description = description;
        this.price = price;
    }
    public Board() {
    // constructor rỗng để tiện dùng trong DAO
}

    // ===== Getters & Setters =====
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

    public String getDisplay() {
        return display;
    }
    public void setDisplay(String display) {
        this.display = display;
    }

    public String getLoadingScreen() {
        return loadingScreen;
    }
    public void setLoadingScreen(String loadingScreen) {
        this.loadingScreen = loadingScreen;
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
