<nav class="navbar navbar-expand-lg">
	<div class="container-fluid">
		<a href="/"><div class="brand-box">
				<h4>CodePost</h4>
			</div></a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<div class="nav-spacer"></div>
			<a class="nav-link" href="create-post">Make A Post</a>

			<div class="navbar-nav me-auto mb-2 mb-lg-0"></div>
			<form class="d-flex" action="search" method="POST">
				<input class="form-control me-2" type="text" name="query"
					placeholder="search posts" aria-label="Search" required
					style="width: 40vw;">
				<button class="btn btn-primary" type="submit">Search</button>
			</form>
		</div>
	</div>
</nav>