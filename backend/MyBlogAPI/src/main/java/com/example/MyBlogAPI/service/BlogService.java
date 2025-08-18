package com.example.MyBlogAPI.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.example.MyBlogAPI.model.BlogPost;
import com.example.MyBlogAPI.model.BlogPostImage;
import com.example.MyBlogAPI.model.Likes;
import com.example.MyBlogAPI.model.User;
import com.example.MyBlogAPI.repository.BlogPostImageRepository;
import com.example.MyBlogAPI.repository.BlogPostRepository;
import com.example.MyBlogAPI.repository.LikesRepository;
import com.example.MyBlogAPI.repository.UserRepository;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class BlogService {
	@Autowired
	private BlogPostRepository blogPostRepository;
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private BlogPostImageRepository blogPostImageRepository;
	
	@Autowired
	private LikesRepository likesRepository;

	public BlogPost addBlogPost(BlogPost blogPost, String authorEmail) throws Exception {
		// check if the author is a valid user
		User author = userRepository.findByEmail(authorEmail)
				.orElseThrow(() -> new UsernameNotFoundException("## No user with username: " + authorEmail + " found! ##"));
		blogPost.setAuthor(author);
		
		// set current time
		LocalDateTime currTime = LocalDateTime.now();
		blogPost.setCreatedAt(currTime);
		blogPost.setUpdatedAt(currTime);
		
		return blogPostRepository.save(blogPost);
	}
	
	public List<BlogPost> viewAllBlogPosts() {
		return blogPostRepository.findAll();
	}

	public BlogPost viewBlogPostById(int id) {
		return blogPostRepository.findById(id)
				.orElseThrow(() -> new IllegalArgumentException("## Blog post with id " + id + " not found! ##"));
	}
	
	public BlogPostImage addBlogPostImage(int id, MultipartFile imageFile) throws Exception {
		// check if the post exists
		BlogPost blogPost = blogPostRepository.findById(id)
				.orElseThrow(() -> new IllegalArgumentException("## Blog post with id " + id + " not found! ##"));
		
		// validate content type
	    String contentType = imageFile.getContentType();
	    if (contentType == null || 
	        !(contentType.equalsIgnoreCase("image/jpeg") || 
	          contentType.equalsIgnoreCase("image/jpg") || 
	          contentType.equalsIgnoreCase("image/png"))) {
	        throw new IllegalArgumentException("## Invalid image format! Only JPG, JPEG, or PNG files are allowed. ##");
	    }
	    
		BlogPostImage blogPostImage = new BlogPostImage(
			0, blogPost, imageFile.getOriginalFilename(), contentType, imageFile.getBytes()
		);
		return blogPostImageRepository.save(blogPostImage);
	} 
	
	public BlogPostImage getBlogPostImage(int postId, int imageId) {
		BlogPost post = blogPostRepository.findById(postId)
				.orElseThrow(() -> new IllegalArgumentException("## Blog post with id " + postId + " not found! ##"));
		
		List<BlogPostImage> images = post.getImages();
		if (images == null || images.isEmpty()) {
			throw new IllegalArgumentException("## Blog post with id " + postId + " doesn't have any image! ##");
		}
		
		return images.stream().filter(img -> img.getId() == imageId).findFirst()
				.orElseThrow(() -> new IllegalArgumentException("## Blog post image with id " + imageId + " not found! ##"));			
	}
	
	public Likes likePostById(int postId, String likedByEmail) {
		// check if the post and user exists
        BlogPost likedPost = blogPostRepository.findById(postId)
                .orElseThrow(() -> new IllegalArgumentException("## Blog post with id " + postId + " not found! ##"));

        User likedBy = userRepository.findByEmail(likedByEmail)
                .orElseThrow(() -> new IllegalArgumentException("## User with email " + likedByEmail + " not found! ##"));

        // save the like if not already done
        return likesRepository.findByLikedPostAndLikedBy(likedPost, likedBy)
                .orElseGet(() -> likesRepository.save(new Likes(0, likedBy, likedPost)));
    }
	
	public void unlikePostById(int postId, String likedByEmail) {
		// check if the post and user exists
		BlogPost likedPost = blogPostRepository.findById(postId)
                .orElseThrow(() -> new IllegalArgumentException("## Blog post with id " + postId + " not found! ##"));

        User likedBy = userRepository.findByEmail(likedByEmail)
                .orElseThrow(() -> new IllegalArgumentException("## User with email " + likedByEmail + " not found! ##"));
        
        // delete the like if exists
        likesRepository.deleteByLikedPostAndLikedBy(likedPost, likedBy);
    }
	
	public boolean hasUserLikedPost(int postId, String likedByEmail) {
		// check if the post and user exists
        BlogPost likedPost = blogPostRepository.findById(postId)
                .orElseThrow(() -> new IllegalArgumentException("## Blog post with id " + postId + " not found! ##"));

        User likedBy = userRepository.findByEmail(likedByEmail)
                .orElseThrow(() -> new IllegalArgumentException("## User with email " + likedByEmail + " not found! ##"));

        // search if the like exists
        return likesRepository.existsByLikedPostAndLikedBy(likedPost, likedBy);
    }
	
	public long getLikesCountOfPostById(int postId) {
		// check if the post exists
        BlogPost likedPost = blogPostRepository.findById(postId)
                .orElseThrow(() -> new IllegalArgumentException("## Blog post with id " + postId + " not found! ##"));

        return likesRepository.countByLikedPost(likedPost);
    }
	
}
