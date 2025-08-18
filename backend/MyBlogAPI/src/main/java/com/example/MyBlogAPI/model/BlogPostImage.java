package com.example.MyBlogAPI.model;

import java.util.Arrays;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.Lob;
import jakarta.persistence.ManyToOne;

@Entity
public class BlogPostImage {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long id;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumn(name = "post_id", nullable = false)
	@JsonIgnoreProperties({"images", "likes", "author"})
	private BlogPost post;
	
	@Column(nullable = false)
	private String filename;
	
	@Column(nullable = false)
	private String contentType;
	
	@Lob
	@Column(name = "image_data", nullable = false, columnDefinition = "MEDIUMBLOB")
	private byte[] imageBytes;

	public BlogPostImage() {
	}

	public BlogPostImage(long id, BlogPost post, String filename, String contentType, byte[] imageBytes) {
		this.id = id;
		this.post = post;
		this.filename = filename;
		this.contentType = contentType;
		this.imageBytes = imageBytes;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public BlogPost getPost() {
		return post;
	}

	public void setPost(BlogPost post) {
		this.post = post;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getContentType() {
		return contentType;
	}

	public void setContentType(String contentType) {
		this.contentType = contentType;
	}

	public byte[] getImageBytes() {
		return imageBytes;
	}

	public void setImageBytes(byte[] imageBytes) {
		this.imageBytes = imageBytes;
	}

	@Override
	public String toString() {
		return "BlogPostImage [id=" + id + ", post=" + post + ", filename=" + filename + ", contentType=" + contentType
				+ ", imageBytes=" + Arrays.toString(imageBytes) + "]";
	}
	
}
