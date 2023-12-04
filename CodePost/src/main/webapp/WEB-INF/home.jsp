<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<jsp:include page="_head.jsp" />
<body>
	<jsp:include page="_navbar.jsp" />
	<c:if test="${message != null}">
		<h4 class="message">${message}</h4>
	</c:if>
	<c:forEach var="post" items="${posts}">
		<a href="/post?id=${post.id}" class="post-listing-link">
			<div class="container listing">
				<div class="post-brief">
					<div class="row">
						<div class="col-12 col-lg">
							<h3 class="card-title text-black text-center">${post.title}</h3>
						</div>
					</div>
					<div class="spacer"></div>
					<div class="row">
						<div class="col-5 d-flex justify-content-end">
							<h5 class="card-subtitle text-black">By, ${post.author}.</h5>
						</div>
						<div class="col-1"></div>
						<div class="col-6 d-flex justify-content-start">
							<h5 class="card-subtitle text-black">language:
								${post.language}</h5>
						</div>
					</div>

				</div>
			</div>
		</a>
	</c:forEach>
	<jsp:include page="_footer.jsp" />
</body>
</html>