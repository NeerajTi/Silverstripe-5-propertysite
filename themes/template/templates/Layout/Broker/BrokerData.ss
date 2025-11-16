<% include MainHeader %>

	<% include Header %>

		<div class="area_135_section project_list_view">
			<div class="container">
				<div class="head_section d-md-flex justify-content-between gap-5">
					<div class="header-left d-flex align-items-center gap-3">
						<img src="/themes/template/images/user_thumb.png" alt="User Thumb">
						<div class="content">
							<h3>$Name</h3>
							<span>Broker</span>
						</div>
					</div>
					<div class="close_profile align-content-end gap-2 hide-on-mobile"><a href="/dashboard/"><i class="fa-solid fa-eye"></i> Indikator für offene Profile schließen</a></div>
				</div>
				<div class="mid_section gap-3">
					<div class="row">
						<div class="col-lg-3 col-sm-12">
							<div class="wrap">
								<div class="title">Kontaktdaten</div>
								<div class="information">
									<div class="address">$Adresse</div>
									<div class="email">$Email</div>
									<div class="phone">$Telefon</div>
								</div>
							</div>
						</div>
						<div class="col-lg-9 col-sm-12">
							<div class="wrap content" style="min-height:198px;">
								<h4>Persönliche Angaben</h4>
								<p>$Description</p>
							</div>
						</div>
					</div>
				</div>
				<div class="last_section">
					<div class="row">
						<div class="col-lg-3 col-sm-12 order-2 order-md-0">
							<div class="landlord_head">
								<h3>Vermieter</h3>

								<% loop $getWorkerInformationByMember %>
									<div class="header-left d-flex align-items-center gap-3">
										<img src="/themes/template/images/user_thumb.png" alt="User Thumb">
										<div class="content">
											<h4>$FirstName $LastName</h4>
											<div class="email"><i class="fa-solid fa-envelope"></i> E-mail: $Email</div>
											<div class="phone"><i class="fa-solid fa-phone"></i> Tel: $CountryCode-$Telefon</div>
										</div>
									</div>
								<% end_loop %>
							</div>
							<div class="close_profile align-content-end gap-2 show-on-mobile"><a href="/dashboard/"><i class="fa-solid fa-eye"></i> Indikator für offene Profile schließen</a></div>
						</div>
						<div class="col-lg-9 col-sm-12">
							<% loop Projecten %>
								<div class="kamer asas">
									<div class="row no-gutters">
										<div class="col-md-4 col-xs-12">
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

										<div class="col-md-8 col-xs-12">
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
														<i class="fa-regular fa-heart wishlist"></i>
														<a class="btn" href="#">Wohnung ansehen</a>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							<% end_loop %>
						</div>
					</div>
				</div>
			</div>
		</div>

	<% include Footer %>

<% include MainFooter %>