package com.codepost.data;

import java.util.List;

import org.springframework.stereotype.Service;

import com.codepost.entities.Post;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

@Transactional
@Service
public class PostDAOImpl implements PostDAO {
	@PersistenceContext
	private EntityManager em;

	@Override
	public List<Post> findAll() {
		String query = "SELECT p FROM Post p ORDER BY createdOn DESC";
		return em.createQuery(query, Post.class).getResultList();
	}

	@Override
	public Post findById(int id) {
		return em.find(Post.class, id);
	}

	@Override
	public Post save(Post post) {
		em.persist(post);
		return post;
	}

	@Override
	public Post update(Post post) {
		Post managed = em.find(Post.class, post.getId());
		managed.setAuthor(post.getAuthor());
		managed.setTitle(post.getTitle());
		managed.setDescription(post.getDescription());
		managed.setCodeSnippet(post.getCodeSnippet());
		managed.setLanguage(post.getLanguage());
		return managed;
	}

	@Override
	public void delete(int id) {
		Post post = em.find(Post.class, id);
		if (post != null) {
			em.remove(post);
		}
	}

	@Override
	public List<Post> search(String query) {
		String jpql = "SELECT p FROM Post p WHERE p.title LIKE :query OR p.description LIKE :query OR p.author LIKE :query OR p.codeSnippet LIKE :query";
		query = "%" + query + "%";
		return em.createQuery(jpql, Post.class).getResultList();
	}

}
