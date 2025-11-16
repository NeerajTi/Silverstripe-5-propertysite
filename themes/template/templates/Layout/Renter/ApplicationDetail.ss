	<% include MainHeader %>

	<% include Header %>
<div class="mydata white_bg">
			<div class="container">
				<div class="back_btn"><a href="/renter-dashboard/applications" class="back-link"><i class="fa-solid fa-arrow-left"></i> Zur Übersicht</a></div>
				<div class="intrest_section progress_form">
					<h3>es besteht Interesse</h3>
					<div class="date">$Application.CreatedDate</div>
					<div class="spacer-30"></div>
					<div class="row">
                   
						<div class="col-xl-5 col-lg-12 col-md-12 col-sm-12">
						<% if $apartmentContact %>
							<div class="contact_member">
								<div class="user_img">
                                <% if $apartmentContact.Image %>
                                <img src="$apartmentContact.Image.URL" alt="$apartmentContact.FirstName $apartmentContact.LastName">
                                <% else %>
                                <img src="/themes/template/images/user_thumb.png" alt="User Thumb">
                                <% end_if %>
                                </div>
								<h4 class="show-on-mobile">$apartmentContact.FirstName $apartmentContact.LastName</h4>
								<div class="user_info">
									<h4 class="hide-on-mobile">$apartmentContact.FirstName $apartmentContact.LastName</h4>
									<div class="email"><i class="fa-solid fa-envelope"></i> E-mail: $apartmentContact.Email</div>
									<div class="phone"><i class="fa-solid fa-phone"></i> Tel: $apartmentContact.Telefon</div>
								</div>
							</div>
						<% end_if %>
							<div class="project_view">
									<div class="image">
									<a href="/stadtteile-berlins/view/$ID">    
								<% if $Apartment.Bilder.Exists %>
  <img src="$Apartment.Bilder.First.Fill(400,300).URL" alt="$Apartment.Bilder.First.Title.ATT">
<% else %>
  <img src="/themes/template/images/image-placeholder.svg" alt="">
<% end_if %>
									</a>
								</div>

								<div class="project_info">
									<div class="project_name_price">
										<h3>
											<a href="/stadtteile-berlins/view/$ID">$Apartment.Address.Street</a>
											<span class="small">$Apartment.Address.Stadt</span>
										</h3>
										<div class="code">$Apartment.GroupNumber</div>
									</div>
									<div class="project_extra_info d-flex">
										<div class="beschikbaarvan icon_text flex-1">
											<i class="fa-regular fa-calendar"></i>
											<div class="label">Bezugsfrei ab</div>
											<div class="value">$Apartment.Details.Abdate</div>
										</div>
										<div class="surface icon_text flex-2">
											<i class="fa-solid fa-wheelchair"></i>
											<div class="label">Bohnberchtingungschein</div>
											<div class="value">&nbsp;</div>
										</div>
									</div>
									<div class="project_extra_info d-flex">
										<div class="surface icon_text">
											<i class="fa-solid fa-house"></i>
											<div class="label">Wohnfläche</div>
											<div class="value">$Apartment.Details.Wohnflache &#13217;</div>
										</div>
										<div class="beschikbaarvan icon_text">
											<i class="fa-regular fa-calendar"></i>
											<div class="label">Badezimmer</div>
											<div class="value">$Apartment.Details.Badezimmer</div>
										</div>
										
										<div class="number_of_bed icon_text">
											<i class="fa-solid fa-bed"></i>
											<div class="label">Schlafzimmer</div>
											<div class="value">$Apartment.Details.Schlafzimmer</div>
										</div>
									</div>
								</div>
							</div>

						</div>
						<div class="col-xl-7 col-lg-12 col-md-12 col-sm-12">
							<div class="form_control">
								<div class="row">
									<div class="col-md-6 mb-4 mb-md-0">
										<input readonly type="text" value="$Profile.FirstName" placeholder="Name">
									</div>
									<div class="col-md-6">
										<input readonly type="text" value="$Profile.LastName" placeholder="Nachname">
									</div>
								</div>
							</div>
							<div class="form_control">
								<div class="col-md-12">
									<input readonly value="$Profile.Email" type="text" placeholder="Email@emailtje.de">
								</div>
							</div>
							<div class="form_control">
								<div class="row">
									<div class="col-md-4 mb-4 mb-md-0">
										<select disabled>
											<option <% if $Profile.CountryCode=='+49' %>selected<% end_if %>>Deutschland (+49)</option>
											<option <% if $Profile.CountryCode=='+43' %>selected<% end_if %>>Österreich (+43)</option>
											<option <% if $Profile.CountryCode=='+41' %>selected<% end_if %>>Schweiz (+41)</option>
										</select>
									</div>
									<div class="col-md-8">
										<input readonly value="$Profile.Telefon" type="text" placeholder="123456789">
									</div>
								</div>
							</div>
							<div class="form_control">
								<div class="col-md-12">
									<textarea placeholder="">$Application.Description</textarea>
								</div>
							</div>
							<div class="form_control">
								<div class="row">
									<div class="col-md-4">
										<label>Stadtteil</label>
										<input readonly type="text" value="$Application.Stadtteil" placeholder="€ 0 - 2015">
									</div>
									<div class="col-md-8">
										<div class="radio_group form_control">
											<label class="form-label left_side">SCHUFA - BonitätsCheck</label>
											<div class="d-flex">
												<label class="radio-wrapper">
													<input readonly type="radio" <% if $Application.CreditCheck=='Ja' %>checked<% end_if %> name="anrede"><span class="custom-radio"></span> Ja
												</label>
												<label class="radio-wrapper">
													<input readonly type="radio" <% if $Application.CreditCheck=='Nein' %>checked<% end_if %> name="anrede"> <span class="custom-radio"></span> Nein
												</label>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="form_control">
								<div class="row">
									<div class="col-md-4 mb-4 mb-md-0">
										<label>Preis</label>
										<input readonly type="text" value="$Application.Price" placeholder="€ 0 - 2015">
									</div>
									<div class="col-md-4 mb-4 mb-md-0">
										<label>Wohnungflache</label>
										<input readonly type="text" value="$Application.Wohnungflache" placeholder="0 - 250">
									</div>
									<div class="col-md-4">
										<label>Zimmer</label>
										<input readonly type="text" value="$Application.Zimmer" placeholder="Egal">
									</div>
								</div>
							</div>
							<div class="form_control">
								<div class="row">
									<div class="col-md-4 mb-4 mb-md-0">
										<label>Was suchen sie?</label>
										<input readonly type="text" value="$Application.lookingfor" placeholder="">
									</div>
									<div class="col-md-4 mb-4 mb-md-0">
										<label>Wohnberechtigungsschein</label>
										<input readonly type="text" value="$Application.Wohnberechtigungsschein" placeholder="">
									</div>
									<div class="col-md-4">
										<label>Haustiere</label>
										<input readonly type="text" value="$Application.Heizungsart" placeholder="">
									</div>
								</div>
							</div>
							<div class="form_control">
								<div class="row">
									<div class="col-md-4 mb-4 mb-md-0">
										<label>Erwachsene</label>
										<input readonly value="$Application.Erwachsene" type="text" placeholder="">
									</div>
									<div class="col-md-4 mb-4 mb-md-0">
										<label>Kinder</label>
										<input readonly value="$Application.Kinder" type="text" placeholder="">
									</div>
									<div class="col-md-4">
										<label>Netto Haushaltseinkommen</label>
										<input readonly value="$Application.HouseholdIncome" type="text" placeholder="€">
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--Nachrichten End-->

	<% include Footer %>

<% include MainFooter %>