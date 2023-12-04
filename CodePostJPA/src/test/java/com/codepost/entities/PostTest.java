package com.codepost.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.time.Month;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.codepost.entities.Language;
import com.codepost.entities.Post;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

class PostTest {
    private static EntityManagerFactory emf;
    private EntityManager em;

    @BeforeAll
    static void setUpBeforeClass() throws Exception {
        emf = Persistence.createEntityManagerFactory("CodePostJPA");
    }

    @AfterAll
    static void tearDownAfterClass() throws Exception {
        emf.close();
    }

    @BeforeEach
    void setUp() throws Exception {
        em = emf.createEntityManager();
    }

    @AfterEach
    void tearDown() throws Exception {
        em.close();
    }

    @Test
    void test_Post_entity_mapping_title() {
        Post post = em.find(Post.class, 1);
        assertNotNull(post);
        assertEquals("Hello, World! in rust!", post.getTitle());
    }

    @Test
    void test_Post_entity_mapping_language() {
        Post post = em.find(Post.class, 1);
        assertNotNull(post);
        assertEquals(Language.RUST, post.getLanguage());
    }

    @Test
    void test_Post_entity_mapping_codeSnippet() {
        Post post = em.find(Post.class, 1);
        assertNotNull(post);
        assertEquals("fn main() {\n  println!(\"Hello, World!\");\n}", post.getCodeSnippet());
    }

    @Test
    void test_Post_entity_mapping_createdOn() {
        Post post = em.find(Post.class, 1);
        assertNotNull(post);
        assertEquals(2023, post.getCreatedOn().getYear());
        assertEquals(Month.DECEMBER, post.getCreatedOn().getMonth());
    }

    @Test
    void test_Post_entity_mapping_lastUpdated() {
        Post post = em.find(Post.class, 1);
        assertNotNull(post);
        assertEquals(2023, post.getLastUpdated().getYear());
        assertEquals(Month.DECEMBER, post.getLastUpdated().getMonth());
    }

    @Test
    void test_Post_entity_mapping_author() {
        Post post = em.find(Post.class, 1);
        assertNotNull(post);
        assertEquals("jakersnell", post.getAuthor());
    }
}
