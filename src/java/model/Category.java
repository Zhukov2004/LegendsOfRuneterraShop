package model;

public class Category {
    private int id;
    private String name;
    private String slug;
    private String description;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getSlug() { return slug; }
    public void setSlug(String slug) { this.slug = slug; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    private int postCount;
public int getPostCount() { return postCount; }
public void setPostCount(int postCount) { this.postCount = postCount; }

}
