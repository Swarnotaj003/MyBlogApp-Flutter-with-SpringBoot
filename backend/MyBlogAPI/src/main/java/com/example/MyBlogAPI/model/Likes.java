package com.example.MyBlogAPI.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

@Entity
public class Likes {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long id;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumn(name = "user_id", nullable = false)
	@JsonIgnoreProperties({"password", "posts", "likes"})
	private User likedBy;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumn(name = "post_id", nullable = false)
	@JsonIgnoreProperties({"author", "images", "likes"})
	private BlogPost likedPost;

	public Likes() {
	}

	public Likes(long id, User likedBy, BlogPost likedPost) {
		this.id = id;
		this.likedBy = likedBy;
		this.likedPost = likedPost;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public User getLikedBy() {
		return likedBy;
	}

	public void setLikedBy(User likedBy) {
		this.likedBy = likedBy;
	}

	public BlogPost getLikedPost() {
		return likedPost;
	}

	public void setLikedPost(BlogPost likedPost) {
		this.likedPost = likedPost;
	}

	@Override
	public String toString() {
		return "Likes [id=" + id + ", likedBy=" + likedBy + ", likedPost=" + likedPost + "]";
	}
	
}
