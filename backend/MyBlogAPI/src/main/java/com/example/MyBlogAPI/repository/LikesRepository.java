package com.example.MyBlogAPI.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.MyBlogAPI.model.BlogPost;
import com.example.MyBlogAPI.model.Likes;
import com.example.MyBlogAPI.model.User;

@Repository
public interface LikesRepository extends JpaRepository<Likes, Integer> {
	
	public Optional<Likes> findByLikedPostAndLikedBy(BlogPost likedPost, User likedBy);

	public boolean existsByLikedPostAndLikedBy(BlogPost likedPost, User likedBy);

	public long countByLikedPost(BlogPost likedPost);

	public void deleteByLikedPostAndLikedBy(BlogPost likedPost, User likedBy);
	
}
