package com.example.MyBlogAPI.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.MyBlogAPI.model.BlogPost;

@Repository
public interface BlogPostRepository extends JpaRepository<BlogPost, Integer>{
	
}
