<div class="container news_page news-section">
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
			<div class="col-md-6 news-items">
				<div class="news-card">
					<div class="news_info">
						<h3 class="news-title">$Title</h3>
						<div class="news-summary">$Content.LimitCharacters(50,'...')</div>
						<a href="$Link" class="read-more-button">Weiterlesen</a>
					</div>
				</div>
			</div>
		<% end_loop %>
	</div>
</div>
