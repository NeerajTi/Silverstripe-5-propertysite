<% if $VolledigeURL == Succes %>
<div class="container kamercontent">
	<div class="row">
		<div class="col-md-12">	
			<h1 class="aanbod-heading">Bedauerlicherweise! Dieses Zimmer ist nicht mehr verfügbar.</h1>
		</div>
		<div class="col-md-6 col-xs-12 afbeelding kamer-bestaat-niet">
			<img src="{$ThemeDir}/images/afbeelding.JPG" alt="img-afbeelding"/>
		</div>		
		<div class="col-md-6 col-xs-12 tekst kamer-bestaat-niet">
			<img src="{$ThemeDir}/images/content.JPG" alt="img-content"/>
		</div>
		<div class="col-md-12">
			<h3 class="subtitel">Vielleicht ist eines dieser Zimmer für Sie?</h3>
		</div>
	</div>
	<% loop RandomKamers %>
	<div class="row">
		<div class="col-md-12">
			<div class="kamer">
				<div class="row">
					<div class="col-md-3 col-xs-12">
					<a href="$Link">
						<div class="img-holder" style="background:URL($AffiliateImage); background-size:cover; background-position: center;">
						</div>
					</a>
					</div>

					<div class="col-md-6 col-xs-12">
					<b class="kamer-straat"><a href="$Link">$Address</a></b>
					<a href="$Link" target="_blank" class="bekijkkamer hidden-xs hidden-sm">Dieses Zimmer ansehen</a>
					<div class="info">
						<span class="type">$Type</span>
						<span class="oppervlakte">$Area</span>
						<span class="aanbod-prijs">$Price p/m</span>
					</div>
					<p class="beschrijving">$Description.LimitCharacters(100)</p>
					</div>

					<div class="col-md-3 hidden-xs hidden-sm">
					<a href="$Link" class="img-holder">
						<img class="img-responsive" src="http://maps.googleapis.com/maps/api/staticmap?markers=$Address+$City&zoom=12&size=300x300&key=AIzaSyCjcE8VsBJzt3WedD-sBUUrCne_H1eW848" alt="$Zipcode">
					</a>      
					</div>      
				</div>
			</div>
		</div>
	</div>	
	<% end_loop %>
</div>
<% else %>
<div class="container">
	<article>
		<h1 class="aanbod-heading">$Title</h1>
		<div class="content">$Content</div>
	</article>
</div>
<% end_if %>