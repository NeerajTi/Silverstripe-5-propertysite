<div class="breadcrumbs" id="Breadcrumbs">
	<div class="container">	
		<div class="row">
			<div class="col-md-12">
				<a href="/"><i class="fa fa-home"></i></a> <i class="fa fa-angle-right"></i> <a href="$Link">$Title</a> <i class="fa fa-angle-right"></i> <% with Kamer %>$Type $Title $City<% end_with %>
			</div>
		</div>
	</div>
</div>

<div class="container kamercontent">
	<div class="row">
		<% include adsens %>
	<% loop Kamer %>

	
$availableFromdate.Format('dd-MM-y') 
	<div class="col-md-12 col-xs-12"><h1 class="aanbod-heading">$Type $Title</h1></div>
	
	<div class="col-md-6 col-xs-12 tekst">
	
		<div class="kamer-detail">
			<table class="kamer-table">
				<tbody>

					<tr>
						<td>Type:</td>
						<td>
							<% if $kindLabel = 'shared room' %> Mehrbettzimmer ($bedroomSize 	&#13217;) im <% end_if %>
							<% if $kindLabel = 'private room' %> WG-Zimmer ($bedroomSize 	&#13217;) im <% end_if %>
							<% if $kindLabel = 'entire place' %>  Gesamte  <% end_if %>
							  
							<% if $typeLabel = 'apartment' %> Apartment<% end_if %>
							<% if $typeLabel = 'house' %> Wohnung <% end_if %>
							<% if $typeLabel = 'building' %> Wohnung <% end_if %>
						</td>
					
					</tr>

					<tr>
						<td>Preis</td>
						<td>€$Price</td>
					</tr>
					<tr>
						<td>Verfügbar </td>
						<td> $availableFromdate.Format('dd-MM-y') </td>
					</tr>

					<tr>
						<td>Adresse</td>
						<td>$Address</td>
					</tr>
					<tr>
						<td>Wohnungseigentum</td>
						<td>$Oppervlakte m²</td>
					</tr>
					<tr>
						<td>Postleitzahl</td>
						<td>$Zipcode</td>
					</tr>
			
					<tr>
						<td>Stadt</td>
						<td>$City</td>
					</tr>
				
					



				</tbody>
			</table>
			</br>
			<p>$Description.LimitWordCount(100).RAW</p>
			<a href="$AffiliateLink" target="_blank" class="meerinfo" rel="noindex, nofollow">Mehr Informationen</a>
			<!-- <a href="$AffiliateLink" target="_blank" class="meerinfo" rel="noindex, nofollow"> Mehr Fotos </a> -->
			<input class="vorige-pagina" type="button" value="Vorherige Seite" onclick="history.go(-1);"></input>
		</div>
		
		
	</div>

	<div class="col-md-6 col-xs-12 afbeelding">
	
		<div class="tabContainer">
			<ul class="nav nav-tabs">
				<li class="kamer-tab"><a class="tab active" tab-id="tab1">Foto</a></li>
				<li class="kamer-tab"><a class="tab" tab-id="tab2">Karte</a></li>
			</ul>
			
			<div id="tab1" class="tabContents">
				<% if $AffiliateImage %>
				<div class="glightbox3" data-gallery="glightbox">
					<a href="$AffiliateImage" title="$Title" target="_blank" rel="noindex, nofollow" class="glightbox">
						<img class="img-responsive" src="$AffiliateImage" alt="$Title" title="$Title">						
					</a>
					</div>
					<% end_if %>
					<% if $AffiliateImage2 %>
					<div class="glightbox3" data-gallery="glightbox" style="display: none;">
						<a href="$AffiliateImage2" title="$Title" target="_blank" rel="noindex, nofollow" class="glightbox">
							<img class="img-responsive" src="$AffiliateImage2" alt="$Title" title="$Title">						
						</a>
					</div>
					<% end_if %>
					<% if $AffiliateImage3 %>
					<div class="glightbox3" data-gallery="glightbox" style="display: none;">
						<a href="$AffiliateImage3" title="$Title" target="_blank" rel="noindex, nofollow" class="glightbox">
							<img class="img-responsive" src="$AffiliateImage3" alt="$Title" title="$Title">						
						</a>
					</div>
					<% end_if %>
					<% if $AffiliateImage4 %>
					<div class="glightbox3" data-gallery="glightbox" style="display: none;">
						<a href="$AffiliateImage4" title="$Title" target="_blank" rel="noindex, nofollow" class="glightbox">
							<img class="img-responsive" src="$AffiliateImage4" alt="$Title" title="$Title">						
						</a>
					</div>
					<% end_if %>
					<% if $AffiliateImage5 %>
					<div class="glightbox3" data-gallery="glightbox" style="display: none;">
						<a href="$AffiliateImage5" title="$Title" target="_blank" rel="noindex, nofollow" class="glightbox">
							<img class="img-responsive" src="$AffiliateImage5" alt="$Title" title="$Title">						
						</a>
					</div>
					<% end_if %>
					<% if $AffiliateImage6 %>
					<div class="glightbox3" data-gallery="glightbox" style="display: none;">
						<a href="$AffiliateImage6" title="$Title" target="_blank" rel="noindex, nofollow" class="glightbox">
							<img class="img-responsive" src="$AffiliateImage6" alt="$Title" title="$Title">						
						</a>
					</div>
					<% end_if %>
					<% if $AffiliateImage7 %>
					<div class="glightbox3" data-gallery="glightbox" style="display: none;">
						<a href="$AffiliateImage7" title="$Title" target="_blank" rel="noindex, nofollow" class="glightbox">
							<img class="img-responsive" src="$AffiliateImage7" alt="$Title" title="$Title">						
						</a>
					</div>
					<% end_if %>
					<% if $AffiliateImage8 %>
					<div class="glightbox3" data-gallery="glightbox" style="display: none;">
						<a href="$AffiliateImage8" title="$Title" target="_blank" rel="noindex, nofollow" class="glightbox">
							<img class="img-responsive" src="$AffiliateImage8" alt="$Title" title="$Title">						
						</a>
					</div>
					<% end_if %>
					<% if $AffiliateImage9 %>
					<div class="glightbox3" data-gallery="glightbox" style="display: none;">
						<a href="$AffiliateImage9" title="$Title" target="_blank" rel="noindex, nofollow" class="glightbox">
							<img class="img-responsive" src="$AffiliateImage9" alt="$Title" title="$Title">						
						</a>
					</div>
					<% end_if %>
					<% if $AffiliateImage10 %>
					<div class="glightbox3" data-gallery="glightbox" style="display: none;">
						<a href="$AffiliateImage10" title="$Title" target="_blank" rel="noindex, nofollow" class="glightbox">
							<img class="img-responsive" src="$AffiliateImage10" alt="$Title" title="$Title">						
						</a>
					</div>
					<% end_if %>
					<% if $AffiliateImage11 %>
					<div class="glightbox3" data-gallery="glightbox" style="display: none;">
						<a href="$AffiliateImage11" title="$Title" target="_blank" rel="noindex, nofollow" class="glightbox">
							<img class="img-responsive" src="$AffiliateImage11" alt="$Title" title="$Title">						
						</a>
					</div>
					<% end_if %>
					<% if $AffiliateImage12 %>
					<div class="glightbox3" data-gallery="glightbox" style="display: none;">
						<a href="$AffiliateImage12" title="$Title" target="_blank" rel="noindex, nofollow" class="glightbox">
							<img class="img-responsive" src="$AffiliateImage12" alt="$Title" title="$Title">						
						</a>
					</div>
					<% end_if %>
					<% if $AffiliateImage13 %>
					<div class="glightbox3" data-gallery="glightbox" style="display: none;">
						<a href="$AffiliateImage13" title="$Title" target="_blank" rel="noindex, nofollow" class="glightbox">
							<img class="img-responsive" src="$AffiliateImage13" alt="$Title" title="$Title">						
						</a>
					</div>
					<% end_if %>
					<% if $AffiliateImage14 %>
					<div class="glightbox3" data-gallery="glightbox" style="display: none;">
						<a href="$AffiliateImage14" title="$Title" target="_blank" rel="noindex, nofollow" class="glightbox">
							<img class="img-responsive" src="$AffiliateImage14" alt="$Title" title="$Title">						
						</a>
					</div>
					<% end_if %>
					<% if $AffiliateImage15 %>
					<div class="glightbox3" data-gallery="glightbox" style="display: none;">
						<a href="$AffiliateImage15" title="$Title" target="_blank" rel="noindex, nofollow" class="glightbox">
							<img class="img-responsive" src="$AffiliateImage15" alt="$Title" title="$Title">						
						</a>
					</div>
					<% end_if %>
					<% if $AffiliateImage16 %>
					<div class="glightbox3" data-gallery="glightbox" style="display: none;">
						<a href="$AffiliateImage16" title="$Title" target="_blank" rel="noindex, nofollow" class="glightbox">
							<img class="img-responsive" src="$AffiliateImage16" alt="$Title" title="$Title">						
						</a>
					</div>
					<% end_if %>
					<% if $AffiliateImage17 %>
					<div class="glightbox3" data-gallery="glightbox" style="display: none;">
						<a href="$AffiliateImage17" title="$Title" target="_blank" rel="noindex, nofollow" class="glightbox">
							<img class="img-responsive" src="$AffiliateImage17" alt="$Title" title="$Title">						
						</a>
					</div>
					<% end_if %>
					<% if $AffiliateImage18 %>
					<div class="glightbox3" data-gallery="glightbox" style="display: none;">
						<a href="$AffiliateImage18" title="$Title" target="_blank" rel="noindex, nofollow" class="glightbox">
							<img class="img-responsive" src="$AffiliateImage18" alt="$Title" title="$Title">						
						</a>
					</div>
					<% end_if %>
					<% if $AffiliateImage19 %>
					<div class="glightbox3" data-gallery="glightbox" style="display: none;">
						<a href="$AffiliateImage19" title="$Title" target="_blank" rel="noindex, nofollow" class="glightbox">
							<img class="img-responsive" src="$AffiliateImage19" alt="$Title" title="$Title">						
						</a>
					</div>
					<% end_if %>
					<% if $AffiliateImage20 %>
					<div class="glightbox3" data-gallery="glightbox" style="display: none;">
						<a href="$AffiliateImage20" title="$Title" target="_blank" rel="noindex, nofollow" class="glightbox">
							<img class="img-responsive" src="$AffiliateImage20" alt="$Title" title="$Title">						
						</a>
					</div>
					<% end_if %>
					<% if $AffiliateImage21 %>
					<div class="glightbox3" data-gallery="glightbox" style="display: none;">
						<a href="$AffiliateImage21" title="$Title" target="_blank" rel="noindex, nofollow" class="glightbox">
							<img class="img-responsive" src="$AffiliateImage21" alt="$Title" title="$Title">						
						</a>
					</div>
					<% end_if %>
					<% if $AffiliateImage22 %>
					<div class="glightbox3" data-gallery="glightbox" style="display: none;">
						<a href="$AffiliateImage22" title="$Title" target="_blank" rel="noindex, nofollow" class="glightbox">
							<img class="img-responsive" src="$AffiliateImage22" alt="$Title" title="$Title">						
						</a>
					</div>
					<% end_if %>
					<% if $AffiliateImage23 %>
					<div class="glightbox3" data-gallery="glightbox" style="display: none;">
						<a href="$AffiliateImage23" title="$Title" target="_blank" rel="noindex, nofollow" class="glightbox">
							<img class="img-responsive" src="$AffiliateImage23" alt="$Title" title="$Title">						
						</a>
					</div>
					<% end_if %>
			</div>
			<div id="tab2" class="tabContents hide">
			
					<div style=""><div id="mymap-canvas" style="height:500px; width:100%;max-width:100%;"><iframe style="height:100%;width:100%;border:0;" frameborder="0" src="https://www.google.com/maps/embed/v1/place?q=$City,+$$Address&key=AIzaSyCfb-eiIrgMep_e9DbwR0z8SFuDA4YulbM"></iframe></div><style>#mymap-canvas img.text-marker{max-width:none!important;background:none!important;}img{max-width:none}</style></div>			</div>			

			
			</div>			
			
			<div class="kamer-meta">
				$Address
			</div>
			<div class="reageer">
				<a href="$AffiliateLink" target="_blank"><div class="reageer-btn">Anbieter kontaktieren!</div></a>
			</div>
		</div>
	</div>	
	<% end_loop %>
	</div>
	
				<% include adsens %>
</div>



