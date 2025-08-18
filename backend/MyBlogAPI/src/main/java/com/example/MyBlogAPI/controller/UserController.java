package com.example.MyBlogAPI.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.MyBlogAPI.model.User;
import com.example.MyBlogAPI.service.UserService;

@Controller
@RequestMapping("/api/auth")
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@PostMapping("/register")
	public ResponseEntity<?> register(@RequestBody User user) {
		try {
			User newUser = userService.register(user);
			return new ResponseEntity<>(newUser, HttpStatus.CREATED);
		} catch (DataIntegrityViolationException e) {
			return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		} catch (Exception e) {
			return new ResponseEntity<>(e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@PostMapping("/login")
	public ResponseEntity<?> login(@RequestBody User user) {
		String issuedToken = userService.validateUser(user);
		if (issuedToken != null) {
			return new ResponseEntity<>(issuedToken, HttpStatus.OK);
		}
		return new ResponseEntity<>("## Invalid email or password! ##", HttpStatus.UNAUTHORIZED);
	}
	
}
