<% include KamerZoeken %>

<div class="container">
<div class="row">
	<div class="col-md-12">
		<article>
			<div class="row">
			<div class="col-md-12">
			<% include adsens %>
			</div>
				<div class="col-md-12">
				<h1>$Title</h1>
				</div>
				<div class="col-md-8"></div>
				<% if URLSegment == "home-demo"%>
				<div class="col-md-4 hidden-xs">
					<a href="/jobs-amsterdam" class="buttonHigh">Jobs Amsterdam</a>
				</div>
				<div class="col-md-4 hidden-xs">
					<a href="/studentenvoordeel" class="buttonHigh">Studentenvoordeel</a>
				</div>
				<% end_if %>
			</div>
			<div class="content">$Content</div>
		</article>
	</div>
</div>
</div>

<div class="container main-content">
<div class="row">
	<div class="col-md-3 hidden-sm hidden-xs">
		<div class="filter">
			$ProjectenResultsForm



			<div class="facebook-widget">
				<div class="fb-rechts">
					<a href="$SiteConfig.FacebookPageURL" target="_blank"><img class="fb-logo" src="$ThemeDir/images/fb_logo.png"></a>
					<p>
						<a class="fb-link" href="$SiteConfig.FacebookPageURL" target="_blank">$SiteConfig.FacebookTekst</a>
					</p>
					<iframe class="fb-frame" src="$SiteConfig.FacebookLikeURL" width="89" height="65" style="border:none;overflow:hidden" scrolling="no" frameborder="0" allowtransparency="true"></iframe>
					<a class="fb-link" href="$SiteConfig.FacebookPageURL" target="_blank">
						<button class="fb-btn-link">
							<span class="pluginButtonIcon">
								<svg xmlns="https://www.w3.org/2000/svg" viewBox="0 0 216 216" class="pluginButtonIconSVG"><path fill="white" d="M204.1 0H11.9C5.3 0 0 5.3 0 11.9v192.2c0 6.6 5.3 11.9 11.911.9h103.5v-83.6H87.2V99.8h28.1v-24c0-27.9 17-43.1 41.9-43.111.9 0 22.2.9 25.2 1.3v29.2h-17.3c-13.5 0-16.2 6.4-16.215.9v20.8h32.3l-4.2 32.6h-28V216h55c6.6 0 11.9-5.311.9-11.9V11.9C216 5.3 210.7 0 204.1 0z"></path></svg>
								<i class="pluginButtonIconPNG img sp_plugin-button sx_plugin-button_favblue"></i>
							</span>
							<span class="bekijken">Ansehen</span>
						</button>
					</a>
				</div>
				
				
			<div class="adsensesidebar">
<% include adsens %>
<br/><br/>
</div>
		
			</div>


		</div>
		
		
		
	</div>
	<div class="col-md-9 col-xs-12">
		<% include KamerAanbod %>
	</div>
	<% if $SecondContent %>
	<div class="col-md-12 col-xs-12" style="margin-top:50px; margin-bottom:50px;">
		$SecondContent
	</div>
	<% end_if %>

</div>
</div>
