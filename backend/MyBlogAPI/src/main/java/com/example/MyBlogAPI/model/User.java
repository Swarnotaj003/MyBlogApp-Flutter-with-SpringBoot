package com.example.MyBlogAPI.model;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;

@Entity
public class User {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long id;
	
	@Column(nullable = false)
	private String name;
	
	@Column(nullable = false, unique = true)
	private String email;
	
	@Column(nullable = false)
	private String password;
	
	@Column(columnDefinition = "TEXT")
	private String bio;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "author", cascade = CascadeType.ALL, orphanRemoval = true)
	@JsonIgnoreProperties({"author", "images", "likes"})
	private List<BlogPost> posts;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "likedBy", cascade = CascadeType.ALL, orphanRemoval = true)
	@JsonIgnoreProperties({"likedBy", "likedPost"})
	private List<Likes> likes;

	public User() {
	}

	public User(long id, String name, String email, String password, String bio, List<BlogPost> posts,
			List<Likes> likes) {
		this.id = id;
		this.name = name;
		this.email = email;
		this.password = password;
		this.bio = bio;
		this.posts = posts;
		this.likes = likes;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getBio() {
		return bio;
	}

	public void setBio(String bio) {
		this.bio = bio;
	}

	public List<BlogPost> getPosts() {
		return posts;
	}

	public void setPosts(List<BlogPost> posts) {
		this.posts = posts;
	}

	public List<Likes> getLikes() {
		return likes;
	}

	public void setLikes(List<Likes> likes) {
		this.likes = likes;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", name=" + name + ", email=" + email + ", password=" + password + ", bio=" + bio
				+ ", posts=" + posts + ", likes=" + likes + "]";
	}
	
}
