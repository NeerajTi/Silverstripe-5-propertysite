<% include MainHeader %>

	<% include Header %>
		<div class="area_135_section project_list_view white_bg">
			<div class="container">
				<div class="head_section d-md-flex justify-content-between gap-5">
					<div class="header-left d-flex align-items-center gap-3">
                    <% if $Company.Image %>
                        <img src="$Company.Image.URL" alt="User Thumb">
                    <% else %>
                        <img src="/themes/template/images/user_thumb.png" alt="User Thumb">
                    <% end_if %>
						<div class="content">
							<h3>
							<% if $MemberBasicData.InseriereAls=='broker' %>
							$MemberBasicData.Firmaname
							<% else %>
							$MemberBasicData.FirstName $MemberBasicData.LastName
							<% end_if %>
							</h3>
							<span>Broker</span>
						</div>
					</div>
					<div class="close_profile align-content-end gap-2">
						<span>
							<% if $userType == 'broker' %>
							<i class="fa-solid fa-eye"></i> Indikator für offene Profile schließen
							<% end_if %>
						</span>
					</div>
				</div>
				<div class="mid_section gap-3">
					<div class="row">
					<% if $isLoggedin %>
						<div class="col-xl-12 col-md-12">
						<% else %>
						<div class="col-xl-12 col-md-12 blurdiv">
						<% end_if %>
							<div class="wrap">
								<div class="title">Kontaktdaten</div>
								<div class="information">
									<div class="address">Adresse: $Company.Strabe,$Company.Nr,$Company.Plz,$Company.Ort,$Company.Land</div>
									<div class="email">Email: $Company.Email</div>
									<div class="phone">Telefon: $Company.CountryCode $Company.Telefon</div>
								</div>
							</div>

						</div>

					</div>
				</div>
				<div class="last_section">
					<div class="row">

                             	<% if $isLoggedin && $listusertype=='broker' %>
							<div class="col-md-12 col-xl-3">
							<% else %>
<div class="col-md-12 col-xl-3 blurdiv">
                             <% end_if %>
								<div class="landlord_head">
									<h3>Vermieter</h3>
                                <% loop $Contacts %>
								<div class="header-left d-flex align-items-center gap-3">
								<% if $Image %>
									<img src="$Image.URL" alt="User Thumb">
								<% else %>
									<img src="/themes/template/images/user_thumb.png" alt="User Thumb">
								<% end_if %>
									<div class="content">
										<h4>$FirstName $LastName</h4>
										<div class="email"><i class="fa-solid fa-envelope"></i> E-mail: $Email</div>
										<div class="phone"><i class="fa-solid fa-phone"></i> Tel: $Telefon</div>
									</div>
								</div>
								<% end_loop %>
							</div>
						</div>

						<div class="col-md-12 col-xl-9">
							<%loop Apartments %>
<div class="kamer asas">
<div class="row no-gutters">
							<div class="col-xl-3 col-md-4">
								<div class="image">
									<a href="/stadtteile-berlins/view/$ID">
								<% if $Bilder.Exists %>
  <img src="$Bilder.First.Fill(400,300).URL" alt="$Bilder.First.Title.ATT">
<% else %>
  <img src="/themes/template/images/image-placeholder.svg" alt="">
<% end_if %>
									</a>
									<div class="overlay">
										<a href="/stadtteile-berlins/view/$ID" class="bekijkkamer hidden-sm hidden-xs">
											Diese Wohnung ansehen
										</a>
									</div>
								</div>
							</div>
							<div class="col-xl-9 col-md-8">
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
											<div class="view_icon"><i class="fa-solid fa-eye"></i> <span>$ViewCount</span></div> <div class="view_icon"><i class="fa-solid fa-arrow-pointer"></i> <span>145</span></div>
											<% if $Top.isLoggedin && $Top.showEdit == 'Yes' %>
											<a class="btn" href="/apartment/step10/?apartmentID=$ID">Wohnung bearbeiten</a>
											<% else %>
											<a class="btn" href="/stadtteile-berlins/view/$ID">Wohnung ansehen</a>
											<% end_if %>
										</div>
									</div>
									</div>
									</div>

							</div>
</div>
<%end_loop%>
						</div>
					</div>
				</div>
			</div>
		</div>
	<% include Footer %>

<% include MainFooter %>
