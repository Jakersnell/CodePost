package com.codepost.data;

import java.util.List;

import com.codepost.entities.Post;

public interface PostDAO {
	List<Post> findAll();
	Post findById(int id);
	Post save(Post post);
	Post update(Post post);
	void delete(int id);
	List<Post> search(String query);
}
