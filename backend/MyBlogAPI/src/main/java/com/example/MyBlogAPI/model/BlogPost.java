package com.example.MyBlogAPI.model;

import java.time.LocalDateTime;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;

enum BlogPostTags {
	TECHNOLOGY, HEALTH, TRAVEL, FOOD, EDUCATION, LIFESTYLE, FINANCE, SPORTS, ENTERTAINMENT, NEWS, BUSINESS, SCIENCE,
	ART, HISTORY, MUSIC, MOVIES, BOOKS, RELATIONSHIPS, SELF_IMPROVEMENT, PRODUCTIVITY, ENVIRONMENT, POLITICS, RELIGION,
	CULTURE, FASHION, GAMING, OTHER
}

@Entity
public class BlogPost {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long id;
	
	@Column(nullable = false)
	private String title;
	
	@Column(nullable = false, columnDefinition = "TEXT")
	private String content;
	
	@Enumerated(EnumType.STRING)
	@Column(nullable = false)
	private BlogPostTags tag;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumn(name = "user_id", nullable = false)
	@JsonIgnoreProperties({"password", "posts", "likes"})
	private User author;
	
	private LocalDateTime createdAt;
	
	private LocalDateTime updatedAt;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "post", cascade = CascadeType.ALL, orphanRemoval = true)
	@JsonIgnoreProperties({"post", "imageBytes"})
	private List<BlogPostImage> images;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "likedPost", cascade = CascadeType.ALL, orphanRemoval = true)
	@JsonIgnoreProperties({"likedPost", "likedBy"})
	private List<Likes> likes;
	
	public BlogPost() {
	}

	public BlogPost(long id, String title, String content, BlogPostTags tag, User author, LocalDateTime createdAt,
			LocalDateTime updatedAt, List<BlogPostImage> images, List<Likes> likes) {
		this.id = id;
		this.title = title;
		this.content = content;
		this.tag = tag;
		this.author = author;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
		this.images = images;
		this.likes = likes;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public BlogPostTags getTag() {
		return tag;
	}

	public void setTag(BlogPostTags tag) {
		this.tag = tag;
	}

	public User getAuthor() {
		return author;
	}

	public void setAuthor(User author) {
		this.author = author;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}

	public LocalDateTime getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(LocalDateTime updatedAt) {
		this.updatedAt = updatedAt;
	}

	public List<BlogPostImage> getImages() {
		return images;
	}

	public void setImages(List<BlogPostImage> images) {
		this.images = images;
	}

	public List<Likes> getLikes() {
		return likes;
	}

	public void setLikes(List<Likes> likes) {
		this.likes = likes;
	}

	@Override
	public String toString() {
		return "BlogPost [id=" + id + ", title=" + title + ", content=" + content + ", tag=" + tag + ", author="
				+ author + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + ", images=" + images + ", likes="
				+ likes + "]";
	}
	
}
