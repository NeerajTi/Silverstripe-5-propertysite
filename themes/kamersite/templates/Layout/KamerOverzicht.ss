<div class="container-fluid">
	<div class="breadcrumbs" id="Breadcrumbs">
		<div class="container">	
			<div class="row">
				<div class="col-md-12">
					<a href="/"><i class="fa fa-home"></i></a> <i class="fa fa-angle-right"></i> $Title
				</div>
			</div>
		</div>
	</div>
</div>

<div class="container">
	<article>
		<h1>$Title</h1>
		<div class="content">$Content</div>
	</article>
	
</div>

<div class="container">
	<div class="row">
		<div class="col-md-3 hidden-sm hidden-xs">
			<div class="filter">
				$ProjectenResultsForm
				<!--<div id="map_canvas" style="width: 100%; height: 250px; position: relative; overflow: hidden;"></div>-->
						
				<div class="facebook-widget">
				<div class="fb-rechts">
					<a href="$SiteConfig.FacebookPageURL" target="_blank"><img class="fb-logo" src="$themedResourceURL('images/fb_logo.png')" alt="Facebook Logo"></a>
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
</div>	
					
					
				</div>
<!-- 
				<script src="https://maps.googleapis.com/maps/api/js?v=3.11&sensor=false&key=$SiteConfig.MapsApi" type="text/javascript"></script>

				<script type="text/javascript">
				var markers = [
					<% loop Projecten %>
					["<a href='$Link/'><h4 style='margin-bottom:0px!important;'>$Address</h4></a><a href='$Link'><img src='$AffiliateImage' style='max-height:125px;'/></a><br/> Prijs: &euro;$Price<br/><a href='$Link'><strong>Bekijk kamer</strong></a>", $Latitude, $Longitude],
					<% end_loop %>
				];
				</script>
				
				<script type="text/javascript">
				function initializeMaps() {
					var myOptions = {
					mapTypeId: google.maps.MapTypeId.ROADMAP,
					mapTypeControl: false,
					panControl: false,
					zoomControl: false,
					scaleControl: true,
					maxZoom: 15,
					streetViewControl: false
					};
					var myOptions2 = {
					mapTypeId: google.maps.MapTypeId.ROADMAP,
					mapTypeControl: false,
					panControl: false,
					zoomControl: false,
					scaleControl: true,
					maxZoom: 15,
					streetViewControl: false
					};

					var map = new google.maps.Map(document.getElementById("map_canvas"),myOptions);
					var map2 = new google.maps.Map(document.getElementById("map_canvas2"),myOptions2);
					
					var infowindow = new google.maps.InfoWindow(); 
					var marker, i;
					var bounds = new google.maps.LatLngBounds();

					
					var infowindow2 = new google.maps.InfoWindow(); 
					var marker2, i2;
					var bounds2 = new google.maps.LatLngBounds();				
					
					for (i = 0; i < markers.length; i++) { 
					var pos = new google.maps.LatLng(markers[i][1], markers[i][2]);
					bounds.extend(pos);
					marker = new google.maps.Marker({
						position: pos,
						icon: '$themedResourceURL('images/marker.png')',
						map: map
					});
					google.maps.event.addListener(marker, 'click', (function(marker, i) {
						return function() {
						infowindow.setContent(markers[i][0]);
						infowindow.open(map, marker);
						}
					})(marker, i));
					}

					map.fitBounds(bounds);

					
					for (i2 = 0; i2 < markers.length; i2++) { 
					var pos2 = new google.maps.LatLng(markers[i2][1], markers[i2][2]);
					bounds2.extend(pos2);
					marker2 = new google.maps.Marker({
						position: pos2,
						icon: '$themedResourceURL('images/marker.png')',
						map: map2
					});
					google.maps.event.addListener(marker2, 'click', (function(marker2, i2) {
						return function() {
						infowindow2.setContent(markers[i2][0]);
						infowindow2.open(map2, marker2);
						}
					})(marker2, i2));
					}

					map2.fitBounds(bounds2);				
				}
				google.maps.event.addDomListener(window, 'load', initializeMaps);
				</script>
-->				
			</div>
		</div>
		<div class="col-md-9">	
			<% include KamerAanbod %>
		</div>
	</div>
</div>
