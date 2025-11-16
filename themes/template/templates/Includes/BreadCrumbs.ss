<% if $ClassName == "HomePage" %>
<% else %>
<div class="container">
	<div class="row">
		<div class="col-lg-12 col-12">
		<% if $Level(1) %>
			<div id="Breadcrumbs">
				<a href="$BaseHref"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24"><path fill="currentColor" d="M5 20v-8H2l10-9l4 3.6V4h3v5.3l3 2.7h-3v8h-5v-6h-4v6zm5-9.975h4q0-.8-.6-1.313T12 8.2q-.8 0-1.4.513t-.6 1.312"/></svg></a> » $Breadcrumbs
			</div>
		<% end_if %>
		</div>
	</div>
</div>
<% end_if %>
