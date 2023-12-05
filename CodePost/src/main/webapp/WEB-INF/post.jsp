<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<jsp:include page="_head.jsp" />
<body>

	<jsp:include page="_navbar.jsp" />
	<main>
		<div class="container post-detail mb-3">
			<div class="row">
				<c:choose>
					<c:when test="${delete == true}">
						<c:if test="${error != null}">${error}</c:if>
						<form class="delete-post" action="delete-post.do" method="POST">
							<input type="hidden" id="postId" name="id" value="${post.id}" />
							<h3 class="warning">Are you sure you want to delete this
								post? this action cannot be undone.</h3>
							<button class="btn btn-danger form-control" type="submit">Yes,
								Delete Post</button>
						</form>
					</c:when>
					<c:otherwise>
						<div class="col-8"></div>
						<div class="col-2">
							<a class="btn btn-secondary form-control"
								href="/update-post?id=${post.id}" role="button">Update Post</a>
						</div>
						<div class="col-2">
							<a class="btn btn-secondary form-control"
								href="/delete-post?id=${post.id}" role="button">Delete Post</a>
						</div>
						<!-- <div class="col-2"></div> -->
					</c:otherwise>
				</c:choose>
			</div>
			<div class="spacer"></div>
			<div class="text-center">
				<h2 class="card-title">${post.title}</h2>
			</div>
			<div class="spacer"></div>
			<div class="row">
				<div class="col-2"></div>
				<div class="col-4 ">
					<div class="d-inline-flex">
						<small class="align-bottom">posted by</small>
						<h5 class="card-subtitle post-author">${post.author}</h5>
					</div>

				</div>
				<div class="col-5">
					<h5>Posted on ${post.formattedCreatedOn}</h5>
				</div>
				<div class="col-1"></div>
			</div>
			<div class="row">

				<div class="col-2"></div>
				<div class="col-4">
					<div class="d-inline-flex">
						<small class="align-bottom">language</small>
						<h5 class="card-subtitle post-author">${post.language.value}</h5>
					</div>
				</div>
				<div class="col-5">
					<h5>Last updated on ${post.formattedLastUpdated}</h5>
				</div>
				<div class="col-1"></div>
			</div>
			<div class="spacer"></div>
			<div class="row">
				<div class="col-1"></div>
				<div class="col-10">
					<div class="description text-center">
						<p class="card-text">${post.description}</p>
					</div>
				</div>
				<div class="col-1"></div>
			</div>
			<div class="spacer"></div>
			<div class="spacer"></div>
			<div class="row">
				<div class="col-1"></div>
				<div class="col-10">
					<!--  be super careful about formatting this file, it will mess up how the code displays in browser-->
					<pre><code class="${post.language.fmtClass}"><c:out value="${post.codeSnippet}" escapeXml="false" /></code></pre>
<%-- 					<pre><code class="${post.language.fmtClass}"><c:out value="${post.codeSnippet}" escapeXml="false" /></code></pre> --%>
				</div>
				<div class="col-1"></div>
			</div>
		</div>
	</main>
	<jsp:include page="_footer.jsp" />
</body>
</html>