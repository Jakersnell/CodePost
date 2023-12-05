<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<jsp:include page="_head.jsp" />
<body>
	<jsp:include page="_navbar.jsp" />
	<div class="container">
		<div class="row form-row">
			<div class="col-1"></div>
			<div class="col-10">

				<c:if test="${error != null}">
					<div class="text-center">
						<h5 style="color: red;">${error}</h5>
					</div>
				</c:if>
				<form class="create-post-form" action="${action}.do" method="POST">

					<c:if test="${post != null}">
						<input type="hidden" id="postId" name="id" value="${post.id}" />
					</c:if>
					<!-- Name input -->


					<div class="form-outline mb-4 ">
						<label class="form-label" for="postAuthorInput">Author</label> <input
							type="text" id="postAuthorInput" class="form-control"
							maxlength="30" name="author" value="${post.author}" required />
					</div>


					<!-- Title input -->

					<div class="form-outline mb-4">
						<label class="form-label" for="postTitleInput">Post Title</label>
						<input type="text" id="postTitleInput" class="form-control"
							maxlength="60" name="title" value="${post.title}" required />
					</div>


					<!-- Description -->

					<div class="form-outline mb-4">
						<label class="form-label" for="postDescInput">Description</label>
						<textarea class="form-control" id="postDescInput" rows="4"
							maxlength="350" name="description">${post.description}</textarea>
					</div>


					<!-- Message input -->

					<div class="form-outline mb-4">
						<label class="form-label" for="postCodeSnippetInput">Code
							Snippet</label>
						<textarea class="form-control" id="postCodeSnippetInput" rows="8"
							cols="20" name="codeSnippet"
							placeholder="I recommend pasting this in for proper formatting."
							required>${post.codeSnippet}</textarea>

					</div>

					<!-- Language -->

					<select class="form-select form-select-lg mb-3"
						aria-label=".form-select-lg example" name="language" required>
						<option value="${post.language.upper}" selected>${post.language.value}</option>
						<option value="RUST">Rust</option>
						<option value="JAVA">Java</option>
						<option value="PYTHON">Python</option>
					</select>

					<!-- Submit button -->

					<button class="btn btn-primary form-control" type="submit">Save</button>


				</form>
			</div>
			<div class="col-1"></div>
		</div>
	</div>
	<jsp:include page="_footer.jsp" />
	<script src="/js/fix-form-tabs.js"></script>
</body>
</html>