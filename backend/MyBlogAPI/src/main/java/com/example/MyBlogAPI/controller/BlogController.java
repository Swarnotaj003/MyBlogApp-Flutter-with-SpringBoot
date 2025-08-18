package com.example.MyBlogAPI.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.example.MyBlogAPI.model.BlogPost;
import com.example.MyBlogAPI.model.BlogPostImage;
import com.example.MyBlogAPI.model.Likes;
import com.example.MyBlogAPI.service.BlogService;

@RestController
@RequestMapping("/api/blog")
public class BlogController {
	@Autowired
	private BlogService blogService;	
	
	@PostMapping("/posts")
	public ResponseEntity<?> addBlogPost(@RequestBody BlogPost blogPost) {
		try {
			// Fetch user name (email) of the authorized user
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			String authorEmail = auth.getName();
			
			// Set that user as the author of this new post
			BlogPost addedPost = blogService.addBlogPost(blogPost, authorEmail);
			return new ResponseEntity<>(addedPost, HttpStatus.CREATED);
		} catch (DataIntegrityViolationException e) {
			return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		} catch (Exception e) {
			return new ResponseEntity<>(e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@GetMapping("/posts")
	public ResponseEntity<?> viewAllBlogPosts() {
		List<BlogPost> blogList = blogService.viewAllBlogPosts();
		return new ResponseEntity<>(blogList, HttpStatus.OK);
	}
	
	@GetMapping("/posts/{id}")
	public ResponseEntity<?> viewBlogPostById(@PathVariable int id) {
		try {
			BlogPost blogPost = blogService.viewBlogPostById(id);
			return new ResponseEntity<>(blogPost, HttpStatus.OK);
		} catch (IllegalArgumentException e) {
			return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND);
		}
	}
	
	@PostMapping("/posts/{id}/images")
	public ResponseEntity<?> addBlogPostImage(@PathVariable int id, @RequestParam MultipartFile imageFile) {
		try {
			BlogPostImage image = blogService.addBlogPostImage(id, imageFile);
			return new ResponseEntity<>(image, HttpStatus.CREATED);
		} catch (DataIntegrityViolationException e) {
			return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		} catch (Exception e) {
			return new ResponseEntity<>(e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@GetMapping("/posts/{id}/images/{imageId}")
	public ResponseEntity<?> getBlogPostImage(@PathVariable("id") int postId, @PathVariable int imageId) {
		try {
			BlogPostImage blogPostImage = blogService.getBlogPostImage(postId, imageId);		
			byte[] imageBytes = blogPostImage.getImageBytes();
			return ResponseEntity.ok()
					.contentType(MediaType.valueOf(blogPostImage.getContentType()))
					.body(imageBytes);
		} catch (IllegalArgumentException e) {
			return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND);
		}
	}
	
	@PostMapping("/posts/{id}/likes")
	public ResponseEntity<?> likePostById(@PathVariable("id") int postId) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String likedByEmail = auth.getName();
		try {
			Likes newLike = blogService.likePostById(postId, likedByEmail);
			return new ResponseEntity<>(newLike, HttpStatus.OK);
		} catch (IllegalArgumentException e) {
			return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND);
		}
	}
	
	@DeleteMapping("/posts/{id}/likes")
	public ResponseEntity<?> unlikePostById(@PathVariable("id") int postId) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String likedByEmail = auth.getName();
		try {
			blogService.unlikePostById(postId, likedByEmail);
			return new ResponseEntity<>(HttpStatus.OK);
		} catch (IllegalArgumentException e) {
			return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND);
		}
	}
	
	@GetMapping("posts/{id}/likes/check")
	public ResponseEntity<?> hasUserLikedPost(@PathVariable("id") int postId) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String likedByEmail = auth.getName();
		try {
			boolean liked = blogService.hasUserLikedPost(postId, likedByEmail);
			return new ResponseEntity<>(liked, HttpStatus.OK);
		} catch (IllegalArgumentException e) {
			return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND);
		}
	}
	
	@GetMapping("/posts/{id}/likes/count")
	public ResponseEntity<?> getLikesCountOfPostById(@PathVariable("id") int postId) {
		try {
			long count = blogService.getLikesCountOfPostById(postId);
			return new ResponseEntity<>(count, HttpStatus.OK);
		} catch (IllegalArgumentException e) {
			return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND);
		} 
	}
	
}
