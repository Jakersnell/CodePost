package com.codepost.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.codepost.data.PostDAO;
import com.codepost.entities.Post;
import com.codepost.utils.CharMapper;

@Controller
public class MainController {

	@Autowired
	private PostDAO postDAO;

	@GetMapping
	public ModelAndView home() {
		ModelAndView mav = new ModelAndView("home");
		List<Post> posts = postDAO.findAll();
		mav.addObject("posts", posts);
		return mav;
	}

	@GetMapping("/post")
	public ModelAndView post(@RequestParam("id") int id) {
		ModelAndView mav = new ModelAndView("post");
		Post result = postDAO.findById(id);

		if (result != null) {
			mav.addObject("post", result);
		} else {
			mav.setViewName("error");
		}

		return mav;
	}

	@GetMapping("/create-post")
	public ModelAndView createPost(@RequestParam(name = "error", required = false) String error) {
		ModelAndView mav = new ModelAndView("create-post");
		mav.addObject("action", "/create-post");
		return mav;
	}

	@PostMapping("/create-post")
	public String createPost(@ModelAttribute Post post, RedirectAttributes attr) {
		String redirect = "redirect:/create-post";

		CharMapper mapper = CharMapper.htmlEntityMapper();
		post.setCodeSnippet(mapper.process(post.getCodeSnippet()));
		post = postDAO.save(post);
		redirect = "redirect:/post?id=" + post.getId();
		return redirect;
	}

	@GetMapping("/update-post")
	public ModelAndView updatePost(@RequestParam("id") int id) {
		ModelAndView mav = new ModelAndView("create-post");
		mav.addObject("action", "/update-post");
		Post post = postDAO.findById(id);
		mav.addObject("post", post);
		return mav;
	}

	@PostMapping("/update-post")
	public String updatePost(@ModelAttribute Post post) {
		String view = "redirect:/post?id=" + post.getId();
		post = postDAO.update(post);
		if (post == null) {
			view = "redirect:/error";
		}
		return view;
	}

	@GetMapping("/delete-post")
	public ModelAndView deletePost(@RequestParam("id") int id,
			@RequestParam(name = "error", required = false) String error) {
		ModelAndView mav = new ModelAndView("post");
		Post post = postDAO.findById(id);
		if (post != null) {
			mav.addObject("post", post);
			mav.addObject("delete", true);
			mav.addObject("error", error);
		} else {
			mav.setViewName("error");
		}
		return mav;
	}

	@PostMapping("/delete-post")
	public String deletePost(@RequestParam("id") int id, RedirectAttributes attr) {
		String redirect = "redirect:/";
		postDAO.delete(id);
		attr.addFlashAttribute("message", "Successfully deleted the post.");
		return redirect;
	}

	@GetMapping("/search")
	public ModelAndView search(@RequestParam("query") String query) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("posts", postDAO.search(query));
		return mav;
	}
}
