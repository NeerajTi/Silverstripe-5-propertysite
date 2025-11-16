<div class="container">
	<div class="row">
		<div class="col-md-12">
			<article>
				<h1>$Title</h1>
				<div class="content">$Content</div>
			</article>
		</div>
		
		$Form
		$CommentsForm
		
		<% loop AlleNieuwsArtikelen %>
			<div class="col-md-6">
				<div class="artikel">
					<h2 class="kamer-straat">$Title</h2>
					<p>$Content.LimitCharacters(50,'...')</p>
					<a href="$Link" class="bekijkartikel">Weiterlesen</a>
				</div>
			</div>
		<% end_loop %>
	</div>
</div>