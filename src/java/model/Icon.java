package model;

public class Icon {
    private int id;          // id tự tăng
    private String name;     // tên icon
    private String image;    // link ảnh
    private String rarity;   // độ hiếm (Thường, Hiếm, Sử thi, Huyền thoại)
    private int price;       // giá (Xu)

    // Constructor mặc định
    public Icon() {}

    // Constructor đầy đủ
    public Icon(int id, String name, String image, String rarity, int price) {
        this.id = id;
        this.name = name;
        this.image = image;
        this.rarity = rarity;
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

    public String getImage() {
        return image;
    }
    public void setImage(String image) {
        this.image = image;
    }

    public String getRarity() {
        return rarity;
    }
    public void setRarity(String rarity) {
        this.rarity = rarity;
    }

    public int getPrice() {
        return price;
    }
    public void setPrice(int price) {
        this.price = price;
    }
}
