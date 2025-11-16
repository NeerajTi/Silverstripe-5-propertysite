<div class="container">
	<div class="row">
		<div class="col-md-8 col-sm-12">
			<article>
				<img src="$NieuwsImage.URL" class="img-responsive nieuwsimg"/>
				<h1 class="aanbod-heading" >$Title</h1>
				<div class="post-meta">
					Veröffentlicht auf: $Created.Format(d-m-Y)<% if $LastEdited %>, Zuletzt bearbeitet: $LastEdited.Format(d-m-Y)<% end_if %>
				</div>				
				<div class="content">$Content</div>
				<div class="post-share">
					<span class="text">Teile</span>		
					<span class="share-links">		
						<a href="http://twitter.com/home?status=$AbsoluteLink" class="fa fa-twitter" data-original-title="Delen op Twitter">
							<span class="visuallyhidden">Twitter</span>
						</a>				
						<a href="http://www.facebook.com/sharer.php?u=$AbsoluteLink" class="fa fa-facebook" data-original-title="Delen op Facebook">
							<span class="visuallyhidden">Facebook</span>
						</a>					
						<a href="http://plus.google.com/share?url=$AbsoluteLink" class="fa fa-google-plus" data-original-title="Delen op Google+">
							<span class="visuallyhidden">Google+</span>
						</a>				
						<a href="http://pinterest.com/pin/create/button/?url=$AbsoluteLink&amp;media=" class="fa fa-pinterest" data-original-title="Delen op Pinterest">
							<span class="visuallyhidden">Pinterest</span>
						</a>						
						<a href="mailto:?subject=$Title&amp;body=$AbsoluteLink" class="fa fa-envelope-o" data-original-title="Mailen">
							<span class="visuallyhidden">Email</span>
						</a>
					</span>
				</div>				
			</article>

			$Form
			$CommentsForm

			<% loop AlleNieuwsArtikelen %>
			<div class="col-md-8 col-sm-12">
				<a href="$link">$Title</a>
			</div>
			<% end_loop %>
		</div>
		<% include SideBarHome %>
	</div>
</div>