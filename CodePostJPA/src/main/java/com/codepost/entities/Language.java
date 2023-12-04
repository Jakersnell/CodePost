package com.codepost.entities;

public enum Language {
	RUST("Rust"), JAVA("Java"), PYTHON("Python");

	private String value;
	
	private String fmtClass;

	Language(String value) {
		this.value = value;
		this.fmtClass = "language-" + value.toLowerCase();
	}

	public String getValue() {
		return value;
	}
	
	public String getUpper() {
		return this.value.toUpperCase();
	}
	
	public String getFmtClass() {
		return fmtClass;
	}

}