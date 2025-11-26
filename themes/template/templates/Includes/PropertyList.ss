				<% if $Apartments %>
				<%loop Apartments %>
<div class="kamer asas">
<div class="row no-gutters">
							<div class="col-xl-5 col-md-12 col-xs-12">
								<div class="image">
									<a href="/$Up.CurrentUrl/view/$ID">    
								<% if $Bilder.Exists %>
  <img src="$Bilder.First.Fill(400,300).URL" alt="$Bilder.First.Title.ATT">
<% else %>
  <img src="/themes/template/images/image-placeholder.svg" alt="">
<% end_if %>
									</a>
									<div class="overlay">
										<a href="/$Up.CurrentUrl/view/$ID" class="bekijkkamer hidden-sm hidden-xs">
											Diese Wohnung ansehen
										</a>
									</div>
								</div>
							</div>
							<div class="col-xl-7 col-md-12 col-xs-12">
								<div class="project_info">
									<div class="project_name_price">
										<h3>
											<a href="#;">
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
									
										<% if $Top.isLoggedIn && $Top.userType == 'renter' %>
											  <a href='javascript:void(0)' class="add-to-wishlist" data-objectID="$ID">
											  <% if $IsWishlist %>
											  <i class="fa-solid fa-heart wishlist hide-on-mobile"></i>
											  <% else %>
											  <i class="fa-regular fa-heart wishlist hide-on-mobile"></i>
											  <% end_if %>
											  </a>
										<% else %>
										
										<% end_if %>
											<a class="btn" href="/$Up.CurrentUrl/view/$ID">Wohnung ansehen</a>
										</div>
									</div>
									</div>
									</div>
									
							</div>
</div>
<%end_loop%>
<% else %>
<div class="alert alert-info">
    <p>No Wohnung gefunden</p>
</div>
<% end_if %>
<!--<div class="pagination">
  <% if $Apartments.MoreThanOnePage %>
    <% if $Apartments.NotFirstPage %>
        <a class="prev" href="$Apartments.PrevLink">Vorherige</a>
    <% end_if %>
    <%loop $Apartments.PaginationSummary(4) %>
          <% if $Link %>
              <li <% if $CurrentBool %>class="active"<% end_if %>><a href="$Link">$PageNum</a></li>
          <% else %>
              <li><a href="#" class="ThreeDots" role="button" disabled>...</a> </li>
          <% end_if %>
    <% end_loop %>
    <% if $Apartments.NotLastPage %>
        <a class="next" href="$Apartments.NextLink">Nächste</a>
    <% end_if %>
  <% end_if %>
</div>-->