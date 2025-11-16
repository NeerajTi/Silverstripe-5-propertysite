<div class="col-md-4">
	<div class="sidebarhome">
		<div class="laatstenieuws-bar">
			<h3 class="laatstenieuws-titel">Neuesten Nachrichten</h3>
		</div>
		<ul class="laatstenieuws-berichten">
			<% loop LaatsteNieuws %>
			<li class="bericht"><a href="$link">$Title</a></li>
			<% end_loop %>
		</ul>
	</div>
</div>