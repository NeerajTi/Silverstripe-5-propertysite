	<% loop Apartments %>
			<div class="project_card item">
				<div class="caard">

					<div class="image">
						<a href="/stadtteile-berlins/view/$ID">
                        <% if $Bilder.Exists %>
						<img src="$Bilder.First.Fill(400,300).URL" alt="$Bilder.First.Title.ATT" class="img-holder lazy">
                        <% else %>
  <img src="/themes/template/images/image-placeholder.svg" alt="" class="img-holder lazy">
<% end_if %>
						<div class="overlay">Diese Wohnung ansehen</div>
						</a>
					</div>
					

					<div class="project_info">
						<div class="project_extra_info">
							<div class="surface icon_text">
								<i class="fa-solid fa-house"></i>
								$Details.Wohnflache &#13217;
							</div>
							<div class="number_of_bed icon_text">
								<i class="fa-solid fa-bed"></i>
								$Details.Schlafzimmer
							</div>
							<div class="beschikbaarvan icon_text">
								<i class="fa-regular fa-calendar"></i>
								$Details.Abdate
							</div>
						</div>


						<div class="project_name_price">
							<h3>
								<a href="/stadtteile-berlins/view/$ID">
									$Address.Street</a> <span class="small">$Address.Stadt</span>
								</a>
							</h3>

							<div class="aanbod-prijs">
								€ $Details.Kaltmiete
								<span class="small">p/m</span>
							</div>
						</div>

						<div class="map_view">
						<a href="<%if $Address.GoogleAddress %>https://www.google.com/maps/place/$Address.GoogleAddress<% end_if %>" target=_blank>
								<i class="fa-solid fa-location-dot"></i> Auf der Karte anzeigen
							</a>
						</div>
					</div>

				</div>
			</div>
			<% end_loop %>