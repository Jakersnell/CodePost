package com.codepost.entities;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Objects;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "post")
public class Post {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@Column(name = "author", nullable = false)
	private String author;

	@Column(name = "title", nullable = false)
	private String title;

	@Column(name = "description")
	private String description;

	@Column(name = "code_snippet", nullable = false)
	private String codeSnippet;

	@Enumerated(EnumType.STRING)
	@Column(name = "language", nullable = false)
	private Language language;

	@Column(name = "created_on")
	private LocalDateTime createdOn;

	@Column(name = "last_updated")
	private LocalDateTime lastUpdated;

	public Post() {
		createdOn = LocalDateTime.now();
		lastUpdated = LocalDateTime.now();
	}

	public boolean isValid() { // broken into lines for readability
		boolean titleNotNull = (getTitle() != null);
		boolean authorNotNull = (getAuthor() != null);
		boolean snippetNotNull = (getCodeSnippet() != null);
		boolean languageNotNull = (getLanguage() != null);
		boolean titleUnder60Chars = (getTitle().length() <= 60);
		boolean authorUnder30Chars = (getAuthor().length() <= 30);
		boolean descUnder350Chars = (getDescription().length() <= 350);

		return titleNotNull && authorNotNull && snippetNotNull && languageNotNull && titleUnder60Chars
				&& authorUnder30Chars && descUnder350Chars;

	}

	@Override
	public int hashCode() {
		return Objects.hash(author, codeSnippet, createdOn, description, id, language, lastUpdated, title);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Post other = (Post) obj;
		return Objects.equals(author, other.author) && Objects.equals(codeSnippet, other.codeSnippet)
				&& Objects.equals(createdOn, other.createdOn) && Objects.equals(description, other.description)
				&& id == other.id && language == other.language && Objects.equals(lastUpdated, other.lastUpdated)
				&& Objects.equals(title, other.title);
	}

	@Override
	public String toString() {
		return "Post [id=" + id + ", author=" + author + ", title=" + title + ", description=" + description
				+ ", language=" + language + ", createdOn=" + createdOn + ", lastUpdated=" + lastUpdated + "]";
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getCodeSnippet() {
		return codeSnippet;
	}

	public void setCodeSnippet(String codeSnippet) {
		this.codeSnippet = codeSnippet;
	}

	public Language getLanguage() {
		return language;
	}

	public void setLanguage(Language language) {
		this.language = language;
	}

	public void setLanguage(String language) {
		this.language = Language.valueOf(language);
	}

	public LocalDateTime getCreatedOn() {
		return createdOn;
	}

	public String getFormattedCreatedOn() {
		return dateFmt(getCreatedOn());
	}

	public String dateFmt(LocalDateTime dateTime) {
		return dateTime.format(DateTimeFormatter.ofPattern("dd.MM.yyyy"));
	}

	public void setCreatedOn(LocalDateTime createdOn) {
		this.createdOn = createdOn;
	}

	public LocalDateTime getLastUpdated() {
		return lastUpdated;
	}

	public String getFormattedLastUpdated() {
		return dateFmt(getLastUpdated());
	}

	public void setLastUpdated(LocalDateTime lastUpdated) {
		this.lastUpdated = lastUpdated;
	}

}
