<% include MainHeader %>

	<% include Header %>

		<div class="mydata white_bg favorite_list project_list_view">
			<div class="container">
				<div class="user_name user_info">Hallo<br> $Name</div>
				<div class="back_btn"><a href="/dashboard/" class="back-link"><i class="fa-solid fa-arrow-left"></i> Zur Übersicht</a></div>
				<h1 class="title">$Title</h1>
				<% if $ApartmentFlashMessage %>
					<div class="alert alert-success">$ApartmentFlashMessage</div>
				<% end_if %>
<% if $Apartments %>			
<%loop Apartments %>
<div class="kamer asas wishlist-$ID">
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
											<a href="#;">
											$Address.Street</a> <span class="small">$Address.Stadt</span> <span class="code">$GroupNumber</span>
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
												<div class="view_icon">
                                                <a href='javascript:void(0)' class="add-to-wishlist" data-objectID="$ID">
                                                <i class="fa-solid fa-heart wishlist" aria-hidden="true"></i>
                                                </a>
                                                </div>
											<a class="btn" href="/stadtteile-berlins/view/$ID">zu verarbeiten</a>
										</div>
									</div>
									</div>
									</div>
									
							</div>
</div>
<%end_loop%>
<% else %>
<div class="alert alert-info">Keine Wohnungen in Ihrer Wishlist</div>
<% end_if %>
			
			</div>
		</div>

	<% include Footer %>

<% include MainFooter %>