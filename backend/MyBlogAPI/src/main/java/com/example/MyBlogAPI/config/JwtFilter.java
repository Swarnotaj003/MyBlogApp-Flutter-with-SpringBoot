package com.example.MyBlogAPI.config;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import com.example.MyBlogAPI.service.JwtService;
import com.example.MyBlogAPI.service.MyUserDetailsService;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class JwtFilter extends OncePerRequestFilter {
	
	@Autowired
	private JwtService jwtService;
	
	@Autowired
	private ApplicationContext context;

	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {
		// Process JWT token from Authentication header if not already authenticated
		// Bearer {token}
		String authHeader = request.getHeader("Authorization");
		String token = null;
		String username = null;
		
		try {
			if (authHeader != null && authHeader.startsWith("Bearer ")) {
				token = authHeader.substring(7);
				username = jwtService.extractUsername(token);
			}
			
			if (username != null && SecurityContextHolder.getContext().getAuthentication() == null) {
				UserDetails userDetails = context.getBean(MyUserDetailsService.class).loadUserByUsername(username);
				if (jwtService.validateToken(token, userDetails)) {
					UsernamePasswordAuthenticationToken upaToken = 
							new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
					upaToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
					SecurityContextHolder.getContext().setAuthentication(upaToken);
				}
			}
		} catch (io.jsonwebtoken.ExpiredJwtException e) {
			System.out.println("## Token Expired! ##\n" + e.getMessage());
		} catch (io.jsonwebtoken.security.SignatureException e) {
			System.out.println("## Invalid Signature! ##\n" + e.getMessage());
		} catch (Exception e) {
			System.out.println("## Authentication Failed! ##\n" + e.getMessage());
		}
		filterChain.doFilter(request, response);
	}	
	
}
