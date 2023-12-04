package com.codepost;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;

@SpringBootApplication
@EntityScan("com.codepost")
public class CodePostApplication {

	public static void main(String[] args) {
		SpringApplication.run(CodePostApplication.class, args);
	}

}
