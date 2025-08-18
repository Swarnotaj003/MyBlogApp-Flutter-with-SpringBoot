package com.example.MyBlogAPI.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.MyBlogAPI.model.BlogPostImage;

@Repository
public interface BlogPostImageRepository extends JpaRepository<BlogPostImage, Integer> {
	
}
