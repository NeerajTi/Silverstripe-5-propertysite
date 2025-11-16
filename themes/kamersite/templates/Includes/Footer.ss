<footer class="main-footer" role="contentinfo">
	<div class="container">
		<div class="row">
			<div class="footer-content">
				<div class="col-md-3 col-xs-12 content-blok">
					<h3 class="content-blok-titel">Über uns</h3>
					<ul class="menu-list-footer">
					<li><a href="{$BaseURL}ueber-uns">Über uns</a></li>
					<li><a href="{$BaseURL}Impressum">Impressum</a></li>
					<li><a href="{$BaseURL}datenschutzerklaerung">Datenschutz</a></li>
					<li><a href="{$BaseURL}sitemap.xml">Sitemap</a></li>
					<li><a href="{$BaseURL}geschaeftsbedingungen-agb">Geschäftsbedingungen (AGB)</a></li>
					</ul>
					
				</div>
				<!-- <div class="col-md-3 col-xs-12">
					<h3 class="content-blok-titel">Andere Seiten</h3>
						<div class="content-blok-tekst">
							<p>$SiteConfig.OverigTekst</p>
						</div>
				</div> -->
				<div class="col-md-6 col-xs-12">
					<h3 class="content-blok-titel">Wohnung-Websites</h3>
					<div class="content-blok-tekst">
					<% loop $SubsiteList %>
						<% if $Top.Subsite.ID != $ID %>
						<a href="//$Domain" class="button">$Title</a>
						<% end_if %>
					<% end_loop %>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- <div class="lower-foot">
		<div class="container">
			<div class="row">
				<div class="col-md-12 col-xs-12 lower-content">
					<a href="{$BaseURL}ueber-uns">Über uns</a> |
					<a href="{$BaseURL}Impressum">Impressum</a> |
					<a href="{$BaseURL}datenschutzerklaerung">Datenschutz</a> |
					<a href="{$BaseURL}sitemap.xml">Sitemap</a> |
					<a href="{$BaseURL}geschaeftsbedingungen-agb">Geschäftsbedingungen (AGB)</a>
				</div>
			</div>
		</div>
	</div> -->
</footer>
