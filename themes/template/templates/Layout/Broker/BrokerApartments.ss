<% include MainHeader %>

	<% include Header %>

		<div class="mydata white_bg favorite_list project_list_view">
			<div class="container">
				<div class="user_name user_info">Hallo<br> $Name</div>
				<div class="back_btn"><a href="/dashboard/" class="back-link"><i class="fa-solid fa-arrow-left"></i> Zur Übersicht</a></div>
				<h1 class="title">Alle Ihre wohnungen</h1>
				<% if $ApartmentFlashMessage %>
					<div class="alert alert-success">$ApartmentFlashMessage</div>
				<% end_if %>
				<form method="get" action="/dashboard/brokerapartments" class="search-sort-form">
					<div class="search-sort-wrapper">
						<span class="product_search"><i class="fa-light fa-magnifying-glass" onclick="this.form.submit();"></i> <input type="text" value="$Search" name="s" placeholder=""  class="search-input" /></span>
						<select name="Sort" class="sort-dropdown" onchange="this.form.submit();">
							<option value="">Relevanz</option>
							<option value="Popularity" <% if $Sort == 'Popularity' %>selected<% end_if %>>Popularität</option>
							<option value="PriceLowToHigh" <% if $Sort == 'PriceLowToHigh' %>selected<% end_if %>>Preis niedrig - hoch</option>
							<option value="PriceHighToLow" <% if $Sort == 'PriceHighToLow' %>selected<% end_if %>>Preis hoch - niedrig</option>
							<option value="Date" <% if $Sort == 'Date' %>selected<% end_if %>>Datum</option>
							<option value="Size" <% if $Sort == 'Size' %>selected<% end_if %>>groß</option>
						</select>
					</div>
				</form>
				<% if $Apartments %>
<%loop Apartments %>
<div class="kamer asas" id='apartment-row-$ID'>
<div class="row no-gutters">
							<div class="col-md-5 col-xs-12">
								<div class="image">
									<a href="/apartment/step1/?apartmentID=$ID">    
								<% if $Bilder.Exists %>
  <img src="$Bilder.First.Fill(400,300).URL" alt="$Bilder.First.Title.ATT">
<% else %>
  <img src="/themes/template/images/image-placeholder.svg" alt="">
<% end_if %>
									</a>
									<div class="overlay">
										<a href="/apartment/step1/?apartmentID=$ID" class="bekijkkamer hidden-sm hidden-xs">
											Diese Wohnung ansehen
										</a>
									</div>
								</div>
							</div>
							<div class="col-md-7 col-xs-12">
								<div class="project_info">
									<div class="project_name_price">
										<h3>
											<a href="/stadtteile-berlins/view/$ID">
											$Address.Street</a> <span class="small">$Address.Stadt</span> <span class="code">$ObjectNumber</span>
										</h3>
										<div class="aanbod-prijs">
											€ $Details.Kaltmiete
											<span class="small">Kaltmiete</span>
										</div>
									</div>

									<div class="map_view">
										<a href="<%if $Address.GoogleAddress %>https://www.google.com/maps/place/$Address.GoogleAddress<% end_if %>" target=_blank>
											<i class="fa-solid fa-location-dot"></i> Auf der Karte anzeigen
										</a>
									</div>
									<div class="project_extra_info">
										<div class="info-wrap">
											<div class="beschikbaarvan icon_text">
												<i class="fa-regular fa-calendar"></i>
												<div class="label">Bezugsfrei ab</div>
												<div class="value">$Details.Abdate</div>
											</div>
												<div class="surface icon_text">
												<i class="fa-solid fa-house"></i>
												<div class="label">Wohnfläche</div>
												<div class="value">$Details.Wohnflache &#13217;</div>
											</div>
											<div class="number_of_bed icon_text">
												<i class="fa-solid fa-bed"></i>
												<div class="label">Schlafzimmer</div>
												<div class="value">$Details.Schlafzimmer</div>
											</div>
										</div>
										<div class="view_appartment">
											<div class="view_icon"><i class="fa-solid fa-eye"></i> <span>$ViewCount</span></div> <div class="view_icon"><i class="fa-solid fa-arrow-pointer"></i> <span>145</span></div>
											<a class="btn" href="/apartment/step1/?apartmentID=$ID">Wohnung bearbeiten</a>&nbsp;
											<a class="btn remove-apartment" style="background-color: #dc3545;" href="javascript:void(0);" data-apartment-id="$ID"><i class="fa-solid fa-trash"></i></a>
											<select class="sort-dropdown change-apartment-status" data-apartment-id="$ID">
							<option value="">Change Status</option>
							<option value="draft" <% if $Status== 'draft' %>selected<% end_if %>>Draft</option>
							<option value="Published" <% if $Status== 'Published' %>selected<% end_if %>>Live</option>
						</select>
										</div>
									</div>
									</div>
									</div>
									
							</div>
</div>
<%end_loop%>
<% else %>
				<div class="alert alert-primary" role="alert">
					Keine Wohnungen vorhanden
				</div>
				<% end_if %>
				<!--<% loop Projecten %>
					<div class="kamer asas">
					
						<div class="row no-gutters">
							<div class="col-md-5 col-xs-12">
								<div class="image">
									<a href="<% if $Top.SiteConfig.KamerLink %><% loop Top %>$SiteConfig.KamerLink<% end_loop %>$Link<% else %><% loop Top.Kameroverzichtpagina %>$URLSegment<% end_loop %>$Link<% end_if %>">    
										<img src="$AffiliateImage" alt="$Address">
									</a>
									<div class="overlay">
										<a href="<% if $Top.SiteConfig.KamerLink %><% loop Top %>$SiteConfig.KamerLink<% end_loop %>$Link<% else %><% loop Top.Kameroverzichtpagina %>$URLSegment<% end_loop %>$Link<% end_if %>" class="bekijkkamer hidden-sm hidden-xs">
											Diese Wohnung ansehen
										</a>
									</div>
								</div>
							</div>

							<div class="col-md-7 col-xs-12">
								<div class="project_info">
									<div class="project_name_price">
										<h3>
											<a href="<% if $Top.SiteConfig.KamerLink %><% loop Top %>$SiteConfig.KamerLink<% end_loop %>$Link<% else %><% loop Top.Kameroverzichtpagina %>$URLSegment<% end_loop %>$Link<% end_if %>">
											$Address</a> <span class="small">$Top.SiteConfig.Stad</span> <span class="code">0123456789</span>
										</h3>
										<div class="aanbod-prijs">
											€ $Price
											<span class="small">Kaltmiete</span>
										</div>
									</div>

									<div class="map_view">
										<a href="#">
											<i class="fa-solid fa-location-dot"></i> Auf der Karte anzeigen
										</a>
									</div>

									<div class="project_extra_info">
										<div class="info-wrap">
											<div class="beschikbaarvan icon_text">
												<i class="fa-regular fa-calendar"></i>
												<div class="label">Bezugsfrei ab</div>
												<div class="value">$availableFromdate.Format('dd-MM-y')</div>
											</div>
											<div class="surface icon_text">
												<i class="fa-solid fa-house"></i>
												<div class="label">Wohnfläche</div>
												<div class="value">$EchteOppervlakte &#13217;</div>
											</div>
											<div class="number_of_bed icon_text">
												<i class="fa-solid fa-bed"></i>
												<div class="label">Schlafzimmer</div>
												<div class="value">2</div>
											</div>
										</div>
										<div class="view_appartment">
											<div class="view_icon"><i class="fa-solid fa-eye"></i> <span>312</span></div> <div class="view_icon"><i class="fa-solid fa-arrow-pointer"></i> <span>145</span></div>
											<a class="btn" href="#">zu verarbeiten</a>
										</div>
									</div>
								</div>
							</div>

						</div>
					</div>
				<% end_loop %>-->
			</div>
		</div>

	<% include Footer %>

<% include MainFooter %>