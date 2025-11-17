package model;

import java.sql.Timestamp;

public class Post {
    private int id;
    private String title;
    private String content;
    private int categoryId;
    private String categoryName; // dùng khi JOIN
    private String author;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private String thumbnail;
private String description;

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }

    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }

    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }
    public String getThumbnail() { return thumbnail; }
public void setThumbnail(String thumbnail) { this.thumbnail = thumbnail; }

public String getDescription() { return description; }
public void setDescription(String description) { this.description = description; }

}
