package com.example.MyBlogAPI.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import com.example.MyBlogAPI.service.MyUserDetailsService;

@Configuration
@EnableWebSecurity
public class SecurityConfig {	
	@Autowired
	private JwtFilter jwtFilter;
	
	@Autowired
	private MyUserDetailsService myUserDetailsService;

    @Bean
    SecurityFilterChain securityFilterChain(HttpSecurity httpSecurity) throws Exception {    	
    	return httpSecurity
    		// Disable CSRF token
    		.csrf(customizer -> customizer.disable())
    		// Enable authorization for all requests except auth
    		.authorizeHttpRequests(request -> request
    				.requestMatchers("/api/auth/login", "/api/auth/register")
    				.permitAll()
    				.anyRequest().authenticated())
    		// Enable basic auth through HTTP
//    		.httpBasic(Customizer.withDefaults())
    		// Configure session creation policy
    		.sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
    		// Add JWT filter before username-password filter
    		.addFilterBefore(jwtFilter, UsernamePasswordAuthenticationFilter.class)    		
    	.build();
	}
    
    @Bean
    AuthenticationProvider authenticationProvider() {
    	DaoAuthenticationProvider provider = new DaoAuthenticationProvider(myUserDetailsService);
    	provider.setPasswordEncoder(new BCryptPasswordEncoder(12));
    	return provider;
    }
    
    @Bean
    AuthenticationManager authenticationManager(AuthenticationConfiguration config) throws Exception {
    	return config.getAuthenticationManager();
    }
    
}
