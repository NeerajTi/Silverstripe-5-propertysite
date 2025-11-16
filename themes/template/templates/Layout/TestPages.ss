<% include MainHeader %>

	<% include Header %>

		<div class="login_dashboard" style="display:block;">
			<div class="container">
				<div class="user_name">Hallo<br> Ronald van der Kemp</div>
				<div class="dashboard_cards">
					<h2>alle Informationen auf einen Blick</h2>
					<div class="cards">
						<a href="#">
							<div class="icon"><i class="fa-solid fa-user"></i></div>
							<div class="text">
								<h3>Alle ihre gegevens</h3>
								<p>Ein ubersicht von alle benachrichtigte wohnungen</p>
							</div>
						</a>
					</div>
					<div class="cards">
						<a href="#">
							<div class="icon"><i class="fa-solid fa-house"></i></div>
							<div class="text">
								<h3>Alle ihre wohnungen</h3>
								<p>alle Ihre angebotenen Wohnungen ansehen</p>
							</div>
						</a>
					</div>
					<div class="cards">
						<a href="#">
							<div class="icon"><i class="fa-solid fa-house"></i></div>
							<div class="text">
								<h3>Neue wohnung anb.</h3>
								<p>Biete neue Wohnung</p>
							</div>
						</a>
					</div>
					<div class="cards">
						<a href="#">
							<div class="icon"><i class="fa-solid fa-message"></i></div>
							<div class="text">
								<h3>anhängige Anträge</h3>
								<p>Alle nachrichten</p>
							</div>
						</a>
					</div>
					<div class="cards">
						<a href="#">
							<div class="icon"><i class="fa-solid fa-star"></i></div>
							<div class="text">
								<h3>Abonnoment</h3>
								<p>Nog sneller verhuren</p>
							</div>
						</a>
					</div>
					<div class="cards">
						<a href="#">
							<div class="icon"><i class="fa-solid fa-lightbulb"></i></div>
							<div class="text">
								<h3>Tips</h3>
								<p>Alle diene Dokumente an einem platz</p>
							</div>
						</a>
					</div>
				</div>
				<div class="default_btn"><a href="#">Ausloggen</a></div>

			</div>
		</div>
		
		<div class="white_card" style="display:block;">
			<div class="container">
				<h2>Email-adresse controlle</h2>
				<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Non pulvinar neque laoreet suspendisse interdum consectetur libero id faucibus. Faucibus nisl tincidunt eget nullam non nisi est sit. Pellentesque habitant morbi tristique senectus. Tortor dignissim convallis aenean et tortor at risus viverra adipiscing. Vulputate eu scelerisque felis imperdiet. Turpis egestas maecenas pharetra convallis. Eget egestas purus viverra accumsan in nisl nisi. Amet mauris commodo quis imperdiet massa tincidunt nunc. Sit amet porttitor eget dolor morbi non arcu risus. Lorem ipsum dolor sit amet consectetur adipiscing.</p>
				<div class="button_group">
					<a href="#" class="yellow_btn">andere E-Mail</a> <a class="outline_btn" href="#">andere E-Mail</a>
				</div>
			</div>
		</div>


		<%-- Persönliche Angaben --%>
		<div class="global_custom_form white_100 width_1360" style="display:block;">
			<h2>Persönliche Angaben</h2>

			<div class="radio_group">
				<label class="form-label">Anrede*</label>
				<div class="d-flex">
					<label class="radio-wrapper">
						<input type="radio" name="anrede"><span class="custom-radio"></span> Herr
					</label>
					<label class="radio-wrapper">
						<input type="radio" name="anrede"> <span class="custom-radio"></span> Frau
					</label>
					<label class="radio-wrapper">
						<input type="radio" name="anrede"> <span class="custom-radio"></span> Ansonsten
					</label>
				</div>
			</div>

			<div class="row mb-3">
				<div class="col-6">
					<input placeholder="Vorname*">
				</div>
				<div class="col-6">
					<input placeholder="Nachname*">
				</div>
			</div>

			<div class="row mb-3">
				<div class="col-12">
					<input placeholder="Geburtsdatum">
				</div>
			</div>

			<div class="row mb-3">
				<div class="col-10">
					<input placeholder="Straße*">
				</div>
				<div class="col-2">
					<input placeholder="Nr.*">
				</div>
			</div>

			<div class="row mb-3">
				<div class="col-2">
					<input placeholder="PLZ*">
				</div>
				<div class="col-5">
					<input placeholder="Ort*">
				</div>
				<div class="col-5">
					<input placeholder="Land*"> 
				</div>
			</div>

			<div class="row mb-3">
				<div class="col-4">
					<select>
						<option>Deutschland (+49)</option>
						<option>Österreich (+43)</option>
						<option>Schweiz (+41)</option>
					</select>
				</div>
				<div class="col-8">
					<input placeholder="Telefon*">
				</div>
			</div>

			<div class="row mb-3">
				<div class="col-12">
					<input placeholder="Emailadresse*">
				</div>
			</div>

			<div class="row mb-4">
				<div class="col-6">
					<input placeholder="Website">
				</div>
				<div class="col-6">
					<input placeholder="Fax">
				</div>
			</div>

			<div class="default_btn align_right">
				<a href="#">zur Bestätigung</a>
			</div>
		</div>
		<%-- Persönliche Angaben ends--%>

		<!--Create Account start-->
		<div class="global_custom_form white_100 width_1360 pl_60 pr_60" style="display:block;">
			<div class="container">
				<h1>Um diese wohnung anzusehen brauchen sie einen account</h1>
				<div class="row">
					<div class="col-md-6 order-2 order-sm-1">
						<div class="benefits_accounts">
							<h2>Vorteilen von einen account</h2>
							<ul>
								<li>Vorteil 1</li>
								<li>Vorteil 2</li>
								<li>Vorteil 3</li>
								<li>Vorteil 4</li>
								<li>Vorteil 5</li>
							</ul>
						</div>
					</div>
					<div class="col-md-6 order-1 order-sm-2">
						<div class="create_account">
							<h2>Neues account herstellen</h2>
							<div class="default_btn"><a href="#">Jetzt registrieren</a></div>
							<h3>Jetzt registrieren</h3>
							<div class="default_outline_btn"><a href="#">Einloggen</a></div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--Create Account start-->

		<!--Meine Daten start-->
		<div class="mydata white_bg" style="display:block;">
			<div class="container">
				<div class="back_btn"><a href="#" class="back-link"><i class="fa-solid fa-arrow-left"></i> Zur Übersicht</a></div>
				<h1 class="title">Meine Daten</h1>
				<div class="profile-card">
					<div class="profile-info">
						<div class="profile-icon"><img src="/themes/template/images/user_thumb.png" alt="User Thumb"></div>
						<div class="profile_text">
							<h2>Broker</h2>
							<p>Mietinteressent.in</p>
						</div>
					</div>
					<div class="profile-status">
						<span><i class="fa-solid fa-eye"></i> Inidkator für offene Profile</span>
					</div>
				</div>

				<div class="column-wrapper">
					<div class="left-column">
						<div class="info-block">
							<a href="#">
								<h3>Selbstauskunft</h3>
								<p>um zu sehen</p>
							</a>
						</div>
						<div class="info-block">
							<a href="#">
								<h3>Broker-Informationen</h3>
								<p>um zu sehen</p>
							</a>
						</div>
						<div class="info-block add">
							<a href="#">
								<h3>Mietenprofi <span><i class="fa-solid fa-plus"></i></span></h3>
								<p>Erstellen</p>
							</a>
						</div>
						<div class="info-block add">
							<a href="#">
								<h3>Mietzahlungsnachweis <span><i class="fa-solid fa-plus"></i></span></h3>
								<p>Erstellen</p>
							</a>
						</div>
						<div class="info-block add">
							<a href="#">
								<h3>Identitätsnachweis <span><i class="fa-solid fa-plus"></i></span></h3>
								<p>Erstellen</p>
							</a>
						</div>
						<div class="info-block add">
							<a href="#">
								<h3>Bonitätsauskunft <span><i class="fa-solid fa-plus"></i></span></h3>
								<p>Erstellen</p>
							</a>
						</div>
					</div>

					<div class="right-column">
						<div class="font-opacity-70">RECLAME <br>BVB ABONOMENT</div>
					</div>
				</div>
			</div>
		</div>
		<!--Meine Daten end-->

		<!--Deine favoriten wohnungen start-->
		<div class="mydata white_bg favorite_list project_list_view" style="display:block;">
			<div class="container">
				<div class="back_btn"><a href="#" class="back-link"><i class="fa-solid fa-arrow-left"></i> Zur Übersicht</a></div>
				<h1 class="title">Deine favoriten wohnungen</h1>
				
				<% loop Projecten %>
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
										<i class="fa-solid fa-heart wishlist"></i>
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
		<!--Deine favoriten wohnungen end-->

		<!--Nachrichten start-->
		<div class="mydata white_bg news" style="display:block;">
			<div class="container">
				<div class="back_btn"><a href="#" class="back-link"><i class="fa-solid fa-arrow-left"></i> Zur Übersicht</a></div>
				<h1 class="title">Nachrichten</h1>
				<div class="abo-card">
					<div class="abo-content">
						<h2>Ihr Abonnement läuft bald ab</h2>
						<p class="date-time">15:30 &nbsp; 29-03-2025</p>
						<p class="description">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut…</p>
					</div>
					<div class="abo-actions">
						<div class="menu-dots"><i class="fa-solid fa-ellipsis-vertical"></i></div>
						<div class="default_btn"><a href="#"><i class="fa-solid fa-envelope"></i>um zu sehen</a></div>
					</div>
				</div>

				<div class="abo-card">
					<div class="abo-image"><img src="/themes/template/images/Greifenhagener.jpg" alt="Greifenhagener Thumb"></div>
					<div class="abo-content">
						<h2>Ihr Abonnement läuft bald ab</h2>
						<p class="date-time">15:30 &nbsp; 29-03-2025</p>
						<p class="description">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut…</p>
					</div>
					<div class="abo-actions">
						<div class="menu-dots"><i class="fa-solid fa-ellipsis-vertical"></i></div>
						<div class="default_btn"><a href="#">um zu sehen</a></div>
					</div>
				</div>
			</div>
		</div>
		<!--Nachrichten End-->

		<!--Deine gespeicherte suche start-->
		<div class="mydata white_bg" style="display:block;">
			<div class="container">
				<div class="back_btn"><a href="#" class="back-link"><i class="fa-solid fa-arrow-left"></i> Zur Übersicht</a></div>
				<h1 class="title">Deine gespeicherte suche</h1>
				
				<div class="saved_search_card">
					<div class="criteria">Preis max: 1400 euro, Kaltmiete, Wohnungflache min: 60m², Anzahl zimmer: Egal</div>
					<div class="notification">
						<div class="left_card">
							<label class="switch">
								<input type="checkbox">
								<span class="slider round"></span>
							</label>
							<div class="text"><span>Benachrichtigung</span> Inaktiv</div>
						</div>
						<div class="actions">
							<div class="result-count">132 Wohnungen</div>
							<div class="default_btn"><a href="#">Wohnungen ansehen</a></div>
						</div>
					</div>
				</div>
				<div class="saved_search_card">
					<div class="criteria">Preis max: 1400 euro, Kaltmiete, Wohnfläche min: 60m², Anzahl Zimmer: Egal, Was suchen sie?: Wohnung, Haustiere: Erlaubt</div>
					<div class="notification">
						<div class="left_card">
							<label class="switch">
								<input type="checkbox">
								<span class="slider round"></span>
							</label>
							<div class="text"><span>Benachrichtigung</span> Aktiv, in echtzeit via Email <a href="#">ändern</a></div>
						</div>
						<div class="actions">
							<div class="result-count">86 Wohnungen</div>
							<div class="default_btn"><a href="#">Wohnungen ansehen</a></div>
						</div>
					</div>
				</div>
				<div class="project_list_view favorite_list" style="display:block; ">
					<h2>die 20 neuesten Uploads in Ihren Suchen</h2>
					<% loop Projecten %>
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

								<div class="beschikbaarvan icon_text">
								<i class="fa-regular fa-calendar"></i>
								<div class="label">Bezugsfrei ab</div>
								<div class="value">$availableFromdate.Format('dd-MM-y')</div>
								</div>

								<div class="project_extra_info">
								<div class="info-wrap">
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
									<i class="fa-solid fa-heart wishlist"></i>
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
		<!--Deine gespeicherte suche End-->
		<div class="mydata white_bg" style="display:block;">
			<div class="container">
				<div class="back_btn"><a href="#" class="back-link"><i class="fa-solid fa-arrow-left"></i> Zur Übersicht</a></div>
				<h1 class="title">Mietenprofi</h1>
				<div class="rental_professional">
					<div class="plans-wrapper">
						<div class="plan-box hide-on-mobile">
							<div class="plan-header"></div>
							<ul>
								<li>Direct contact met verhuurder</li>
								<li>Zoekopdrachten speigeren</li>
								<li>Berichten nieuwe woningen</li>
								<li>Lorem ipsum</li>
								<li>Lorem ipsum</li>
							</ul>
						</div>

						<div class="plan-box">
							<div class="plan-header">
								<div class="icon_wrap">
									<div class="icon"><i class="fa-solid fa-building"></i></div>
									<div class="month">1 Monate</div>
								</div>
								<div class="price">14,95 Euro/ Monat</div>
							</div>
							<ul>
								<li><i class="fa-solid fa-check"></i> <span>Direct contact met verhuurder</span></li>
								<li><i class="fa-solid fa-check"></i> <span>Zoekopdrachten speigeren</span></li>
								<li></li>
								<li></li>
								<li></li>
							</ul>
						</div>

						<div class="plan-box active">
							<div class="plan-header">
								<div class="subscription">Ihre Abbonoment</div>
								<div class="icon_wrap">
									<div class="icon"><i class="fa-solid fa-house"></i></div>
									<div class="month">3 Monate</div>
								</div>
								<div class="price">12.95 Euro/ Monat</div>
							</div>
							<ul>
								<li><i class="fa-solid fa-check"></i> <span>Direct contact met verhuurder</span></li>
								<li><i class="fa-solid fa-check"></i> <span>Zoekopdrachten speigeren</span></li>
								<li><i class="fa-solid fa-check"></i> <span>Berichten nieuwe woningen</span></li>
								<li></li>
								<li></li>
							</ul>
						</div>

						<div class="plan-box">
							<div class="plan-header">
								<div class="icon_wrap">
									<div class="icon"><i class="fa-solid fa-building-columns"></i></div>
									<div class="month">6 Monate</div>
								</div>
								<div class="price">9,95 Euro/ Monat</div>
							</div>
							<ul>
								<li><i class="fa-solid fa-check"></i> <span>Direct contact met verhuurder</span></li>
								<li><i class="fa-solid fa-check"></i> <span>Zoekopdrachten speigeren</span></li>
								<li><i class="fa-solid fa-check"></i> <span>Berichten nieuwe woningen</span></li>
								<li><i class="fa-solid fa-check"></i> <span>Lorem ipsum</span></li>
								<li><i class="fa-solid fa-check"></i> <span>Lorem ipsum</span></li>
							</ul>
						</div>
					</div>

					<div class="plan-footer">
						<div class="terms">
							Mindestlaufzeit 6 Monate. Danach Verlängerung auf unbestimmte Zeit zum Monatspreis von 19,99 Euro und jederzeit mit maximal 1-Monatsfrist kündbar.<br>
							Die <a href="#">AGB</a> und <a href="#">Widerrufsbelehrung</a> wurden zur Kenntnis genommen und durch Klick auf „Jetzt Kaufen“ akzeptiert. Alle Preise inkl. MwSt.
						</div>
						<div class="action">
							<div class="default_outline_btn"><a href="#" class="btn-outline">Anhalten</a></div>
							<div class="default_btn"><a href="#" class="btn-filled">Upgrade</a></div>
						</div>
					</div>
				</div>
			</div>
		</div>


		<!--Tips Start-->
		<div class="mydata white_bg" style="display:block;">
			<div class="container">
				<div class="back_btn"><a href="#" class="back-link"><i class="fa-solid fa-arrow-left"></i> Zur Übersicht</a></div>
				<h1 class="title">Tips</h1>

				<div class="card-masonry">
					<div class="card">
						<h3>Lorem ipsum</h3>
						<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque lorem quam, commodo id diam nec, tincidunt convallis felis. Vivamus eu vehicula massa. Vestibulum pellentesque, mi vel ultricies pretium, velit diam ullamcorper lectus, sed vehicula leo lacus at orci. Etiam iaculis ligula eget ex placerat sollicitudin. Sed rutrum vulputate ante, rhoncus mollis elit. Phasellus turpis orci, commodo commodo sapien quis, rutrum</p>
					</div>
					<div class="card">
						<h3>Lorem ipsum</h3>
						<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque lorem quam, commodo id diam nec, tincidunt convallis felis. Vivamus eu vehicula massa. Vestibulum pellentesque, mi vel ultricies pretium, velit diam ullamcorper lectus, sed vehicula leo lacus at orci. Etiam iaculis ligula eget ex placerat sollicitudin. Sed rutrum vulputate ante, rhoncus mollis elit. Phasellus turpis orci, commodo commodo sapien quis, rutrum</p>
					</div>
					<div class="card">
						<h3>Lorem ipsum</h3>
						<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque lorem quam, commodo id diam nec, tincidunt convallis felis. Vivamus eu vehicula massa. Vestibulum pellentesque, mi vel ultricies pretium, velit diam ullamcorper lectus, sed vehicula leo lacus at orci. Etiam iaculis ligula eget ex placerat sollicitudin. Sed rutrum vulputate ante, rhoncus mollis elit. Phasellus turpis orci, commodo commodo sapien quis, rutrum</p>
					</div>
					<div class="card">
						<h3>Lorem ipsum</h3>
						<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque lorem quam, commodo id diam nec, tincidunt convallis felis. Vivamus eu vehicula</p>
					</div>
					<div class="card">
						<h3>Lorem ipsum</h3>
						<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque lorem quam, commodo id diam nec, tincidunt convallis felis. Vivamus eu vehicula</p>
					</div>
					
				</div>
			</div>
		</div>
		<!--Tips End-->

		<!--Inserat erstellen zu Vermietung einer Wohnung Start-->
		<div class="mydata white_bg" style="display:block;">
			<div class="container">
				<div class="back_btn"><a href="#" class="back-link"><i class="fa-solid fa-arrow-left"></i> Zur Übersicht</a></div>
				<h1 class="title">Inserat erstellen zu Vermietung einer Wohnung</h1>

				<div class="progress_form">
					<div class="progress-container">
						<div class="progress_bar" style="width: 30%;"></div>
					</div>
					<div class="row">
						<div class="col-md-10">
							<div class="form_control d-flex">
								<label class="left_side">Objektnummer:</label>
								<input type="text" placeholder="">
							</div>
							<div class="form_control d-flex">
								<label class="left_side">Gruppennummer:</label>
								<input type="text" placeholder="">
							</div>
						</div>
						<div class="col-md-2">
							<div class="tipp">
								<h3><i class="fa-regular fa-lightbulb"></i> Tipp:</h3>
								<div class="small_text">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation</div>
							</div>
						</div>
					</div>
					<div class="radio_group">
						<label class="form-label">Wohnung Type:</label>
						<div class="d-flex">
							<label class="radio-wrapper">
								<input type="radio" name="anrede"><span class="custom-radio"></span> Wohnung
							</label>
							<label class="radio-wrapper">
								<input type="radio" name="anrede"> <span class="custom-radio"></span> WG Zimmer
							</label>
							<label class="radio-wrapper">
								<input type="radio" name="anrede"> <span class="custom-radio"></span> Haus
							</label>
							<label class="radio-wrapper">
								<input type="radio" name="anrede"> <span class="custom-radio"></span> Wohnung auf zeit
							</label>
							<label class="radio-wrapper">
								<input type="radio" name="anrede"> <span class="custom-radio"></span> Grage oder stellplatz
							</label>
						</div>
					</div>
				</div>
				<script>
					document.querySelector('.progress_bar').classList.add('animate');
				</script>
			</div>
		</div>
		<!--Inserat erstellen zu Vermietung einer Wohnung End-->

		<!--neue wohnung – 1 Start-->
		<div class="mydata white_bg"  style="display:block;">
			<div class="container">
				<div class="back_btn"><a href="#" class="back-link"><i class="fa-solid fa-arrow-left"></i> Zur Übersicht</a></div>
				<h1 class="title">Inserat erstellen zu Vermietung einer Wohnung</h1>

				<div class="progress_form">
					<div class="progress-container">
						<div class="progress_bar" style="width: 30%;"></div>
					</div>
					<div class="address_form">
						<h3>Adresse:</h3>
						<div class="form_control d-flex">
							<label class="left_side hide-on-mobile">Strasse*:</label>
							<div class="row">
								<div class="col-md-10 col-9">
									<label class="show-on-mobile">Strasse*:</label>
									<input type="text" placeholder="">
								</div>
								<div class="col-md-2 col-3">
									<div class="d-md-flex align-items-center gap-15">
										<label>Nr*:</label>
										<input type="text" placeholder="">
									</div>
								</div>
							</div>
						</div>
						<div class="form_control d-flex">
							<label class="left_side hide-on-mobile">PLZ*:</label>
							<div class="row">
								<div class="col-md-2 col-3">
									<label class="show-on-mobile">PLZ*:</label>
									<input type="text" placeholder="">
								</div>
								<div class="col-md-10 col-9">
									<div class="d-md-flex align-items-center gap-15">
										<label>Ort*:</label>
										<input type="text" placeholder="">
									</div>
								</div>
							</div>
						</div>
						<div class="radio_group form_control d-flex">
							<label class="form-label left_side">Wohnung Type:</label>
							<div class="d-flex">
								<label class="radio-wrapper">
									<input type="radio" name="anrede"><span class="custom-radio"></span> Ja
								</label>
								<label class="radio-wrapper">
									<input type="radio" name="anrede"> <span class="custom-radio"></span> Nein
								</label>
							</div>
						</div>
						<div class="form_control d-flex">
							<label class="left_side">Stadt*:</label>
							<div class="row">
								<div class="col-md-4">
									<input type="text" placeholder="">
								</div>
								<div class="col-md-8 mobile-mt-10">
									<div class="d-md-flex align-items-center gap-15 justify-right justify-content-between">
										<label>Stadtteil*:</label>
										<select>
											<option>District</option>
										</select>
									</div>
								</div>
							</div>
						</div>
						<div class="default_btn text-right"><a href="#">Weiter</a></div>
					</div>
				</div>
				<script>
					document.querySelector('.progress_bar').classList.add('animate');
				</script>
			</div>
		</div>
		<!--neue wohnung End-->


		<!--Nachrichten Start-->
		<div class="mydata white_bg" style="display:block;">
			<div class="container">
				<div class="back_btn"><a href="#" class="back-link"><i class="fa-solid fa-arrow-left"></i> Zur Übersicht</a></div>
				<div class="intrest_section progress_form">
					<h3>es besteht Interesse</h3>
					<div class="date">11:40 19-02-2025</div>
					<div class="spacer-30"></div>
					<div class="row">
						<div class="col-md-4">
							<div class="contact_member">
								<div class="user_img"><img src="/themes/template/images/user_thumb.png" alt="User Thumb"></div>
								<h4 class="show-on-mobile">Contact 1</h4>
								<div class="user_info">
									<h4 class="hide-on-mobile">Contact 1</h4>
									<div class="email"><i class="fa-solid fa-envelope"></i> E-mail: Loremipsum@mail.de</div>
									<div class="phone"><i class="fa-solid fa-phone"></i> Tel: 06-123456789</div>
								</div>
							</div>

							<div class="project_view">
								<div class="image">
									<a href="wohnung-mieten-berlin/kamer/492419">    
										<img src="https://housinganywhere.imgix.net/room/1148304/8ffc5d55-9535-11e6-bdd5-42010af00008.jpg?auto=format%2Ccompress&amp;cs=srgb&amp;fit=clip&amp;h=1536&amp;w=2048" alt="Greifenhagener Straße">
									</a>
								</div>

								<div class="project_info">
									<div class="project_name_price">
										<h3>
											<a href="wohnung-mieten-berlin/kamer/492419">Greifenhagener Straße</a>
											<span class="small">Berlin</span>
										</h3>
										<div class="code">0123456789</div>
									</div>
									<div class="project_extra_info d-flex">
										<div class="beschikbaarvan icon_text flex-1">
											<i class="fa-regular fa-calendar"></i>
											<div class="label">Bezugsfrei ab</div>
											<div class="value">01-05-2025</div>
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
											<div class="value">42 ㎡</div>
										</div>
										<div class="beschikbaarvan icon_text">
											<i class="fa-regular fa-calendar"></i>
											<div class="label">Badezimmer</div>
											<div class="value">1</div>
										</div>
										
										<div class="number_of_bed icon_text">
											<i class="fa-solid fa-bed"></i>
											<div class="label">Schlafzimmer</div>
											<div class="value">2</div>
										</div>
									</div>
								</div>
							</div>

						</div>
						<div class="col-md-8">
							<div class="form_control">
								<div class="row">
									<div class="col-md-6 mb-4 mb-md-0">
										<input type="text" placeholder="Name">
									</div>
									<div class="col-md-6">
										<input type="text" placeholder="Nachname">
									</div>
								</div>
							</div>
							<div class="form_control">
								<div class="col-md-12">
									<input type="text" placeholder="Email@emailtje.de">
								</div>
							</div>
							<div class="form_control">
								<div class="row">
									<div class="col-md-4 mb-4 mb-md-0">
										<select>
											<option>Deutschland (+49)</option>
											<option>Österreich (+43)</option>
											<option>Schweiz (+41)</option>
										</select>
									</div>
									<div class="col-md-8">
										<input type="text" placeholder="123456789">
									</div>
								</div>
							</div>
							<div class="form_control">
								<div class="col-md-12">
									<textarea placeholder="">Fue popularizado en los 60s con la creación de las hojas "Letraset", las cuales contenian nes de Loremambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas "Letraset", las cuales contenian nes de Lorem</textarea>
								</div>
							</div>
							<div class="form_control">
								<div class="row">
									<div class="col-md-4">
										<label>Stadtteil</label>
										<input type="text" placeholder="€ 0 - 2015">
									</div>
									<div class="col-md-8">
										<div class="radio_group form_control">
											<label class="form-label left_side">SCHUFA - BonitätsCheck</label>
											<div class="d-flex">
												<label class="radio-wrapper">
													<input type="radio" name="anrede"><span class="custom-radio"></span> Ja
												</label>
												<label class="radio-wrapper">
													<input type="radio" name="anrede"> <span class="custom-radio"></span> Nein
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
										<input type="text" placeholder="€ 0 - 2015">
									</div>
									<div class="col-md-4 mb-4 mb-md-0">
										<label>Wohnungflache</label>
										<input type="text" placeholder="0 - 250">
									</div>
									<div class="col-md-4">
										<label>Zimmer</label>
										<input type="text" placeholder="Egal">
									</div>
								</div>
							</div>
							<div class="form_control">
								<div class="row">
									<div class="col-md-4 mb-4 mb-md-0">
										<label>Was suchen sie?</label>
										<input type="text" placeholder="">
									</div>
									<div class="col-md-4 mb-4 mb-md-0">
										<label>Wohnberechtigungsschein</label>
										<input type="text" placeholder="">
									</div>
									<div class="col-md-4">
										<label>Haustiere</label>
										<input type="text" placeholder="">
									</div>
								</div>
							</div>
							<div class="form_control">
								<div class="row">
									<div class="col-md-4 mb-4 mb-md-0">
										<label>Erwachsene</label>
										<input type="text" placeholder="">
									</div>
									<div class="col-md-4 mb-4 mb-md-0">
										<label>Kinder</label>
										<input type="text" placeholder="">
									</div>
									<div class="col-md-4">
										<label>Netto Haushaltseinkommen</label>
										<input type="text" placeholder="€">
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--Nachrichten End-->

		<!--meine daten contacten-->
			<div class="mydata white_bg" style="display:block;">
				<div class="container">
					<div class="back_btn"><a href="#" class="back-link"><i class="fa-solid fa-arrow-left"></i> Zur Übersicht</a></div>
					<h1 class="title">Firma</h1>
					<div class="progress_form filled_form edit_mode">
						<div class="row">
							<div class="col-md-8">
								<div class="form_control">
									<div class="row">
										<div class="col-md-6 mb-4 mb-md-0">
											<input type="text" placeholder="Broker">
										</div>
										<div class="col-md-6">
											<input type="text" placeholder="HRB 12345">
										</div>
									</div>
								</div>
								<div class="form_control">
									<div class="col-md-12">
										<textarea placeholder="">Straße straat 3 12345 Berlin, Deutschland</textarea>
									</div>
								</div>
								<div class="form_control">
									<div class="col-md-12">
										<input type="text" placeholder="Telefon: +49 123456789">
									</div>
								</div>
								<div class="form_control">
									<div class="col-md-12">
										<input type="text" placeholder="Emailadresse@email.de">
									</div>
								</div>
								<div class="form_control">
									<div class="row">
										<div class="col-md-6 mb-4 mb-md-0">
											<input type="text" placeholder="Broker.de">
										</div>
										<div class="col-md-6">
											<input type="text" placeholder="Broker.de">
										</div>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="media"><img class="rounded-3" src="https://placehold.co/122x96" alt="User Placeholder"></div>
								<div class="short_content">ambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas "Letraset", las cuales contenian nes de Loremambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas "Letraset", las cuales contenian nes de Loremambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas "Letraset", las cuales contenian nes de Lorem</div>
							</div>
						</div>
						<div class="default_btn text-right"><a href="#"><i class="fa-solid fa-pen"></i> um zu sehen</a></div>
					</div>
				</div>
			</div>
		<!--meine daten contacten-->

		<!--Alle Ihre wohnungen-->
		<div class="mydata white_bg favorite_list project_list_view" style="display:block;">
			<div class="container">
				<div class="back_btn"><a href="#" class="back-link"><i class="fa-solid fa-arrow-left"></i> Zur Übersicht</a></div>
				<h1 class="title">Alle Ihre wohnungen</h1>
				
				<form method="get" action="/search" class="search-sort-form">
					<div class="search-sort-wrapper">
						<span class="product_search"><i class="fa-light fa-magnifying-glass"></i> <input type="text" name="Search" placeholder="" class="search-input" /></span>
						<select name="Sort" class="sort-dropdown">
							<option value="">Relevanz</option>
							<option value="Popularität">Popularität</option>
							<option value="Preis niedrig - hoch">Preis niedrig - hoch</option>
							<option value="Preis hoch - niedrig">Preis hoch - niedrig</option>
							<option value="Datum">Datum</option>
							<option value="groß">groß</option>
						</select>
					</div>
				</form>

				<% loop Projecten %>
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
				<% end_loop %>
			</div>
		</div>
		<!--Alle Ihre wohnungen-->


		<!--Inserat erstellen zu Vermietung einer Wohnung Start-->
		<div class="mydata white_bg" style="display:block;">
			<div class="container">
				<div class="back_btn"><a href="#" class="back-link"><i class="fa-solid fa-arrow-left"></i> Zur Übersicht</a></div>
				<h1 class="title">Inserat erstellen zu Vermietung einer Wohnung</h1>

				<div class="progress_form radio_btn_list">
					<div class="progress-container">
						<div class="progress_bar" style="width: 30%;"></div>
					</div>
					
					<div class="row">
						<div class="col-md-7">
							<h2>Details:</h2>
							<ul class="double_column">
								<li>
									<div class="radio_group d-flex">
										Einbaukuche:
										<label class="radio-wrapper">
											<input type="radio" name="anrede"><span class="custom-radio"></span>
										</label>
									</div>
								</li>
								<li>
									<div class="radio_group d-flex">
										Balkon/Terasse:
										<label class="radio-wrapper">
											<input type="radio" name="anrede"><span class="custom-radio"></span>
										</label>
									</div>
								</li>
								<li>
									<div class="radio_group d-flex">
										Gaste WC:
										<label class="radio-wrapper">
											<input type="radio" name="anrede"><span class="custom-radio"></span>
										</label>
									</div>
								</li>
								<li>
									<div class="radio_group d-flex">
										WG geeignet:
										<label class="radio-wrapper">
											<input type="radio" name="anrede"><span class="custom-radio"></span>
										</label>
									</div>
								</li>
								<li>
									<div class="radio_group d-flex">
										Aufzug:
										<label class="radio-wrapper">
											<input type="radio" name="anrede"><span class="custom-radio"></span>
										</label>
									</div>
								</li>

								<li>
									<div class="radio_group d-flex">
										Gearten:
										<label class="radio-wrapper">
											<input type="radio" name="anrede"><span class="custom-radio"></span>
										</label>
									</div>
								</li>
								<li>
									<div class="radio_group d-flex">
										Keller:
										<label class="radio-wrapper">
											<input type="radio" name="anrede"><span class="custom-radio"></span>
										</label>
									</div>
								</li>
								<li>
									<div class="radio_group d-flex">
										Stufenlose Zugang:
										<label class="radio-wrapper">
											<input type="radio" name="anrede"><span class="custom-radio"></span>
										</label>
									</div>
								</li>
								<li>
									<div class="radio_group d-flex">
										Wohnberechtigungsschein:
										<label class="radio-wrapper">
											<input type="radio" name="anrede"><span class="custom-radio"></span>
										</label>
									</div>
								</li>
								<li>
									<div class="radio_group d-flex">
										Haustiere erlaubt:
										<label class="radio-wrapper">
											<input type="radio" name="anrede"><span class="custom-radio"></span>
										</label>
									</div>
								</li>
							</ul>
						</div>
						<div class="col-md-4 offset-md-1">
							<h3>Qualitat der Wohnung:</h3>
							<ul>
								<li>
									<div class="radio_group d-flex">
										Neubau:
										<label class="radio-wrapper">
											<input type="radio" name="anrede"><span class="custom-radio"></span>
										</label>
									</div>
								</li>
								<li>
									<div class="radio_group d-flex">
										Einfach:
										<label class="radio-wrapper">
											<input type="radio" name="anrede"><span class="custom-radio"></span>
										</label>
									</div>
								</li>
								<li>
									<div class="radio_group d-flex">
										Gehoben:
										<label class="radio-wrapper">
											<input type="radio" name="anrede"><span class="custom-radio"></span>
										</label>
									</div>
								</li>
								<li>
									<div class="radio_group d-flex">
										Normal:
										<label class="radio-wrapper">
											<input type="radio" name="anrede"><span class="custom-radio"></span>
										</label>
									</div>
								</li>
								<li>
									<div class="radio_group d-flex">
										Luxe:
										<label class="radio-wrapper">
											<input type="radio" name="anrede"><span class="custom-radio"></span>
										</label>
									</div>
								</li>
							</ul>
						</div>
					</div>
					<div class="default_btn text-right"><a href="#">Weiter</a></div>
				</div>
				<script>
					document.querySelector('.progress_bar').classList.add('animate');
				</script>
			</div>
		</div>
		<!--Inserat erstellen zu Vermietung einer Wohnung End-->

		<!--13.3 - neue wohnung – 4 Start-->
		<div class="mydata white_bg" style="display:block;">
			<div class="container">
				<div class="back_btn"><a href="#" class="back-link"><i class="fa-solid fa-arrow-left"></i> Zur Übersicht</a></div>
				<h1 class="title">Inserat erstellen zu Vermietung einer Wohnung</h1>

				<div class="progress_form">
					<div class="progress-container">
						<div class="progress_bar" style="width: 30%;"></div>
					</div>
						<h2 class="mb-3">Details:</h2>
						<form>
							<div class="area_label">Anzahl voorzieningen:</div>
							
							<div class="row">
								<div class="col-md-6">
									<div class="form_control">
										<div class="row">
											<div class="col-md-6">
												<label>Schlafzimmer:</label>
											</div>
											<div class="col-md-6"><input type="text"></div>
										</div>
									</div>	
								</div>

								<div class="col-md-6">
									<div class="form_control">
										<div class="row">
											<div class="col-md-6">
												<label>Badezimmer:</label>
											</div>
											<div class="col-md-6"><input type="text"></div>
										</div>
									</div>
								</div>
							</div>

							<div class="row">
								<div class="col-md-6">
									<div class="form_control">
										<div class="row">
											<div class="col-md-6">
												<label>Etage:</label>
											</div>
											<div class="col-md-6 d-flex align-items-center gap-4">
												<input type="text"> <label>Von</label> <input type="text">
											</div>
										</div>
									</div>
								</div>

								<div class="col-md-6">
									<div class="form_control">
										<div class="row">
											<div class="col-md-6">
												<label>Nutzflache:</label>
											</div>
											<div class="col-md-6">
												<div class="input-group">
													<input type="text">
													<span class="input-group-text">m²</span>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>

							<div class="row mt-3 radio_btn_list">
								<div class="col-md-6">
									<label class="area_label mb-3">Wohnberechtigungsscein:</label>
									<ul>
										<li>
											<div class="radio_group">
												<div class="row">
													<div class="col-md-6 col-8">Erfordelich:</div>
													<div class="col-md-6 col-4">
														<label class="radio-wrapper justify-content-md-start justify-content-sm-end">
															<input type="radio" name="anrede"><span class="custom-radio"></span>
														</label>
													</div>
												</div>	
											</div>
										</li>
										<li>
											<div class="radio_group">
												<div class="row">
													<div class="col-md-6 col-8">Nichterforderlich:</div>
													<div class="col-md-6 col-4">
														<label class="radio-wrapper justify-content-md-start justify-content-sm-end">
															<input type="radio" name="anrede"><span class="custom-radio"></span>
														</label>
													</div>
												</div>	
											</div>
										</li>
									</ul>
								</div>
								<div class="col-md-6">
									<label class="area_label mb-3">Heizungart:</label>
									<ul>
										<li>
											<div class="radio_group">
												<div class="row">
													<div class="col-md-6 col-8">Erfordelich:</div>
													<div class="col-md-6 col-4">
														<label class="radio-wrapper justify-content-md-start justify-content-sm-end">
															<input type="radio" name="anrede"><span class="custom-radio"></span>
														</label>
													</div>
												</div>	
											</div>
										</li>
										<li>
											<div class="radio_group">
												<div class="row">
													<div class="col-md-6 col-8">Nichterforderlich:</div>
													<div class="col-md-6 col-4">
														<label class="radio-wrapper justify-content-md-start justify-content-sm-end">
															<input type="radio" name="anrede"><span class="custom-radio"></span>
														</label>
													</div>
												</div>	
											</div>
										</li>
									</ul>
								</div>
							</div>
							<div class="default_btn text-right"><a href="#">Weiter</a></div>
						</form>
				</div>
				<script>
					document.querySelector('.progress_bar').classList.add('animate');
				</script>
			</div>
		</div>
		<!--13.3 - neue wohnung – 4 End-->

	
		<!--13.3 - neue wohnung – 4 Start-->
		<div class="mydata white_bg" style="display:block;">
			<div class="container">
				<div class="back_btn"><a href="#" class="back-link"><i class="fa-solid fa-arrow-left"></i> Zur Übersicht</a></div>
				<h1 class="title d-flex align-items-center justify-content-between">Selbstauskunft <div class="default_btn hide-on-mobile" style="margin-top:0;"><a href="#">hinzufügen</a></div></h1>
				
				<div class="accordion custom_accordion">
					<div class="accordion-header">
						<div class="header-left d-flex align-items-center">
							<img src="/themes/template/images/user_thumb.png" alt="User Thumb">
							<div class="content">
								<h3>Contacten 1</h3>
								<span>Mietinteressent:in</span>
							</div>
						</div>
						<div class="arrow"><i class="fa-light fa-chevron-down"></i></div>
					</div>
					<div class="accordion-content">
						<div class="d-md-flex gap-5 align-items-end">
							<div class="contact-info">
								<div class="wrap d-flex justify-content-between flex-sm-wrap gap-5">
									<div class="left_text flex-fill"><strong>Boss man</strong></div>
									<div class="right_text flex-fill">Standaard contact</div>
								</div>
								<div class="wrap d-flex justify-content-between flex-sm-wrap gap-5">
									<div class="left_text flex-fill">Boss</div>
									<div class="right_text flex-fill"></div>
								</div>
								<div class="wrap d-flex justify-content-between flex-sm-wrap gap-5">
									<div class="left_text flex-fill">E-mail: Loremipsum@mail.de</div>
									<div class="right_text flex-fill">Zusätizlche E-mail: Loremipsum@mail.de</div>
								</div>
								<div class="wrap d-flex justify-content-between flex-sm-wrap gap-5">
									<div class="left_text flex-fill">Tel: 06-123456789</div>
									<div class="right_text flex-fill">Mobiel: 123456789</div>
								</div>
								<div class="wrap d-flex justify-content-between flex-sm-wrap gap-5">
									<div class="left_text flex-fill">Fax: 123456789</div>
									<div class="right_text flex-fill"></div>
								</div>
							</div>
							
							<div class="area_content">
								ambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas "Letraset", las cuales contenían nes de Lorem
							</div>
							<div class="edit-link"><i class="fa-solid fa-pencil"></i> um zu sehen</div>
						</div>
					</div>
				</div>

				<div class="accordion">
					<div class="accordion-header">
						<div class="header-left d-flex align-items-center">
							<img src="/themes/template/images/user_thumb.png" alt="User Thumb">
							<div class="content">
								<h3>Contacten 1</h3>
								<span>Mietinteressent:in</span>
							</div>
						</div>
						<div class="arrow"><i class="fa-light fa-chevron-down"></i></div>
					</div>
					<div class="accordion-content">
						<p>Details for Contacten 2...</p>
					</div>
				</div>

				<div class="accordion">
					<div class="accordion-header">
						<div class="header-left d-flex align-items-center">
							<img src="/themes/template/images/user_thumb.png" alt="User Thumb">
							<div class="content">
								<h3>Contacten 1</h3>
								<span>Mietinteressent:in</span>
							</div>
						</div>
						<div class="arrow"><i class="fa-light fa-chevron-down"></i></div>
					</div>
					<div class="accordion-content">
						<p>Details for Contacten 3...</p>
					</div>
				</div>

				<div class="default_btn show-on-mobile"><a href="#">hinzufügen</a></div>

				<script>
					const accordions = document.querySelectorAll('.accordion');
					accordions.forEach(acc => {
						acc.querySelector('.accordion-header').addEventListener('click', () => {
							// Optional: Close others before opening
							accordions.forEach(item => {
								if (item !== acc) item.classList.remove('active');
							});
							acc.classList.toggle('active');
						});
					});
				</script>
			</div>
		</div>
		<!--13.3 - neue wohnung – 4 End-->	

		<!-- 13.1 -meine daten contacten – 5-->
		<div class="area_135_section project_list_view" style="display:block;">
			<div class="container">
				<div class="head_section d-md-flex justify-content-between gap-5">
					<div class="header-left d-flex align-items-center gap-3">
						<img src="/themes/template/images/user_thumb.png" alt="User Thumb">
						<div class="content">
							<h3>Name</h3>
							<span>Broker</span>
						</div>
					</div>
					<div class="close_profile align-content-end gap-2"><i class="fa-solid fa-eye"></i> Indikator für offene Profile schließen</div>
				</div>
				<div class="mid_section d-md-flex gap-3">
					<div class="row">
						<div class="col-md-6">
							<div class="wrap">
								<div class="title">Kontaktdaten</div>
								<div class="information">
									<div class="address">Adresse</div>
									<div class="email">Email</div>
									<div class="phone">Telefon</div>
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="wrap content">
								<h4>Persönliche Angaben</h4>
								<p>ambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas "Letraset", las cuales contenian pasajes de Lorem Ipsum, y más recientemente con software de autoedición, como por ejemplo Aldus PageMaker</p>
							</div>
						</div>
					</div>
				</div>
				<div class="last_section">
					<div class="row">
						<div class="col-md-3">
							<div class="landlord_head">
								<h3>Vermieter</h3>
								<div class="header-left d-flex align-items-center gap-3">
									<img src="/themes/template/images/user_thumb.png" alt="User Thumb">
									<div class="content">
										<h4>Contact 1</h4>
										<div class="email"><i class="fa-solid fa-envelope"></i> E-mail: Loremipsum@mail.de</div>
										<div class="phone"><i class="fa-solid fa-phone"></i> Tel: 06-123456789</div>
									</div>
								</div>
								<div class="header-left d-flex align-items-center gap-3">
									<img src="/themes/template/images/user_thumb.png" alt="User Thumb">
									<div class="content">
										<h4>Contact 1</h4>
										<div class="email"><i class="fa-solid fa-envelope"></i> E-mail: Loremipsum@mail.de</div>
										<div class="phone"><i class="fa-solid fa-phone"></i> Tel: 06-123456789</div>
									</div>
								</div>
								<div class="header-left d-flex align-items-center gap-3">
									<img src="/themes/template/images/user_thumb.png" alt="User Thumb">
									<div class="content">
										<h4>Contact 1</h4>
										<div class="email"><i class="fa-solid fa-envelope"></i> E-mail: Loremipsum@mail.de</div>
										<div class="phone"><i class="fa-solid fa-phone"></i> Tel: 06-123456789</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-9">
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
		<!-- 13.1 -meine daten contacten – 5-->

		<!-- 13.5 - Abonnoment – 2-->
		<div class="white_card" style="display:block;">
			<h2>Zahlungsarten</h2>
			<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Non pulvinar neque laoreet suspendisse interdum consectetur libero id faucibus. Faucibus nisl tincidunt eget nullam non nisi est sit. Pellentesque habitant morbi tristique senectus. Tortor dignissim convallis aenean et tortor at risus viverra adipiscing. Vulputate eu scelerisque felis imperdiet.</p>
			<div class="payment_option">
				<div class="payment_card">
					<i class="fa-brands fa-paypal"></i>
					<div class="card_name">PayPal</div>
				</div>
				<div class="payment_card">
					<i class="fa-brands fa-paypal"></i>
					<div class="card_name">PayPal</div>
				</div>
				<div class="payment_card">
					<i class="fa-brands fa-paypal"></i>
					<div class="card_name">PayPal</div>
				</div>
				<div class="payment_card">
					<i class="fa-brands fa-paypal"></i>
					<div class="card_name">PayPal</div>
				</div>
				<div class="default_btn"><a href="#" class="yellow_btn">Zahlen</a></div>
			</div>
		</div>
		<!-- 13.5 - Abonnoment – 2-->

		<!-- 13.3 - neue wohnung – 2 start-->
		<div class="mydata white_bg" style="display:block;">
			<div class="container">
				<div class="back_btn"><a href="#" class="back-link"><i class="fa-solid fa-arrow-left"></i> Zur Übersicht</a></div>
				<h1 class="title">Inserat erstellen zu Vermietung einer Wohnung</h1>

				<div class="progress_form">
					<div class="progress-container">
						<div class="progress_bar" style="width: 30%;"></div>
					</div>
						<h2 class="mb-3">Echdaten:</h2>
						<form>	
							<div class="row">
								<div class="col-md-6">
									<div class="form_control">
										<div class="row">
											<div class="col-md-6">
												<label>Wohnflache*:</label>
											</div>
											<div class="col-md-6">
												<div class="input-group">
													<input type="text">
													<span class="input-group-text">m²</span>
												</div>
											</div>
										</div>
									</div>
									<div class="form_control">
										<div class="row">
											<div class="col-md-6">
												<label>Kaltmiete*</label>
											</div>
											<div class="col-md-6">
												<div class="input-group">
													<input type="text">
													<span class="input-group-text">Euro</span>
												</div>
											</div>
										</div>
									</div>
									<div class="form_control">
										<div class="row">
											<div class="col-md-6">
												<label>Nebenkosten:</label>
											</div>
											<div class="col-md-6">
												<div class="input-group">
													<input type="text">
													<span class="input-group-text">Euro</span>
												</div>
											</div>
										</div>
									</div>
									<div class="area_label">Heizunkosten in Nebenkosen:</div>
									<div class="form_control">
										<div class="row">
											<div class="col-md-6">
												<label>Gesamtmiete*:</label>
											</div>
											<div class="col-md-6">
												<div class="input-group">
													<input type="text">
													<span class="input-group-text">Euro</span>
												</div>
											</div>
										</div>
									</div>
								</div>

								<div class="col-md-6">
									<div class="form_control">
										<div class="row">
											<div class="col-md-6">
												<label>Zimmer*:</label>
											</div>
											<div class="col-md-6">
												<div class="input-group">
													<input type="text">
													<span class="input-group-text">Euro</span>
												</div>
											</div>
										</div>
									</div>
									<div class="form_control">
										<div class="row">
											<div class="col-md-6">
												<label>Verfungbar Ab:</label>
											</div>
											<div class="col-md-6">
												<div class="input-group">
													<span class="input-group-text">Datum</span>
													<input type="text">
												</div>
											</div>
										</div>
									</div>
									<div class="form_control">
										<div class="row">
											<div class="col-md-6">
												<label>Kaution:</label>
											</div>
											<div class="col-md-6">
												<div class="input-group">
													<input type="text">
													<span class="input-group-text">Euro</span>
												</div>
											</div>
										</div>
									</div>
									<div class="tipp" style="max-width:260px;">
										<h3><i class="fa-regular fa-lightbulb"></i> Tipp:</h3>
										<div class="small_text">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et</div>
									</div>
								</div>
							</div>
						
							<div class="default_btn text-right"><a href="#">Weiter</a></div>
						</form>
					</div>
				<script>
					document.querySelector('.progress_bar').classList.add('animate');
				</script>
			</div>
		</div>
		<!-- 13.3 - neue wohnung – 2 End-->

		<!-- 13.3 - neue wohnung – 5 start-->
		<div class="mydata white_bg" style="display:block;">
			<div class="container">
				<div class="back_btn"><a href="#" class="back-link"><i class="fa-solid fa-arrow-left"></i> Zur Übersicht</a></div>
				<h1 class="title">Inserat erstellen zu Vermietung einer Wohnung</h1>

				<div class="progress_form radio_btn_list">
					<div class="progress-container">
						<div class="progress_bar" style="width: 30%;"></div>
					</div>
						<h2 class="mb-3">Details:</h2>
						<form>	
							<div class="row">
								<div class="col-md-4">
									<div class="area_label">Internetgeschwindigkeit:</div>
									<ul>
										<li>
											<div class="radio_group d-flex justify-content-between">
												Alle Geschwindigkiet:
												<label class="radio-wrapper">
													<input type="radio" name="anrede"><span class="custom-radio"></span>
												</label>
											</div>
										</li>
										<li>
											<div class="radio_group d-flex justify-content-between">
												Mind. 100 Mbit/s:
												<label class="radio-wrapper">
													<input type="radio" name="anrede"><span class="custom-radio"></span>
												</label>
											</div>
										</li>
										<li>
											<div class="radio_group d-flex justify-content-between">
												Mind. 250 Mbit/s:
												<label class="radio-wrapper">
													<input type="radio" name="anrede"><span class="custom-radio"></span>
												</label>
											</div>
										</li>
										<li>
											<div class="radio_group d-flex justify-content-between">
												Mind 1000 Mbit/s:
												<label class="radio-wrapper">
													<input type="radio" name="anrede"><span class="custom-radio"></span>
												</label>
											</div>
										</li>
									</ul>
								</div>

								<div class="col-md-4 offset-md-1 mt-4 mt-md-0">
									<div class="area_label">Energieeffiziezklasse:</div>
									<ul>
										<li>
											<div class="radio_group d-flex justify-content-between">
												A
												<label class="radio-wrapper">
													<input type="radio" name="anrede"><span class="custom-radio"></span>
												</label>
											</div>
										</li>
										<li>
											<div class="radio_group d-flex justify-content-between">
												B
												<label class="radio-wrapper">
													<input type="radio" name="anrede"><span class="custom-radio"></span>
												</label>
											</div>
										</li>
										<li>
											<div class="radio_group d-flex justify-content-between">
												C
												<label class="radio-wrapper">
													<input type="radio" name="anrede"><span class="custom-radio"></span>
												</label>
											</div>
										</li>
										<li>
											<div class="radio_group d-flex justify-content-between">
												D+
												<label class="radio-wrapper">
													<input type="radio" name="anrede"><span class="custom-radio"></span>
												</label>
											</div>
										</li>
									</ul>					
								</div>
								<div class="col-md-2 offset-md-1">
									<div class="tipp" style="max-width:260px;">
										<h3><i class="fa-regular fa-lightbulb"></i> Tipp:</h3>
										<div class="small_text">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et</div>
									</div>
								</div>
							</div>
						
							<div class="default_btn text-right"><a href="#">Weiter</a></div>
						</form>
					</div>
				<script>
					document.querySelector('.progress_bar').classList.add('animate');
				</script>
			</div>
		</div>
		<!-- 13.3 - neue wohnung – 5 End-->


		<!-- 13.3 - neue wohnung – 6 start-->
		<div class="mydata white_bg" style="display:block;">
			<div class="container">
				<div class="back_btn"><a href="#" class="back-link"><i class="fa-solid fa-arrow-left"></i> Zur Übersicht</a></div>
				<h1 class="title">Inserat erstellen zu Vermietung einer Wohnung</h1>

				<div class="progress_form global_custom_form">
					<div class="progress-container">
						<div class="progress_bar" style="width: 30%;"></div>
					</div>
						<h2 class="mb-3">Beschreibungen:</h2>
						<form>
							<div class="area_label">Uberschrift*:</div>
							<div class="row align-items-start">
								<div class="col">
									<div class="textarea">
										<textarea></textarea>
										<span class="words_count">Noch 100 zeigen</span>
									</div>
								</div>
								<div class="col-auto mt-4 mt-md-0">
									<div class="tipp" style="max-width:260px;">
										<h3><i class="fa-regular fa-lightbulb"></i> Tipp:</h3>
										<div class="small_text">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut</div>
									</div>
								</div>
							</div>
						
							<div class="default_btn text-right mt-5"><a href="#">Weiter</a></div>
						</form>
					</div>
				<script>
					document.querySelector('.progress_bar').classList.add('animate');
				</script>
			</div>
		</div>
		<!-- 13.3 - neue wohnung – 6 End-->

		<!-- 13.1 -meine daten contacten – 8 Start-->
		<div class="mydata white_bg" style="display:block;">
			<div class="container">
				<div class="progress_form">
					<div class="row align-items-center">
						<div class="col-md-5">
							<div class="image"><img src="/themes/template/images/Mail-sent-rafiki.svg" alt=""></div>
						</div>
						<div class="col-md-7">
							<h2 class="mb-3">Danke! <br>Ihre Nachricht wurde gesendet</h2>
							<div class="row">
								<div class="col-md-8">
									<div class="form_control">
										<label>Nachricht</label>
										<textarea placeholder="">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Non pulvinar neque laoreet suspendisse interdum consectetur libero id faucibus. Faucibus nisl tincidunt eget nullam non nisi est sit.</textarea>
									</div>
								</div>
								<div class="col-md-4">
									<div class="form_control">
										<label>Stadtteil</label>
										<input type="text" placeholder="">
									</div>
									<div class="radio_group form_control">
										<label class="form-label left_side">SCHUFA - BonitätsCheck</label>
										<label class="radio-wrapper">
											<input type="radio" name="anrede" checked><span class="custom-radio"></span> Ja
										</label>
									</div>
								</div>
							</div>
							<div class="form_control">
								<div class="row">
									<div class="col-md-4 mb-4 mb-md-0">
										<label>Preis</label>
										<input type="text" placeholder="€ 0 - 2015">
									</div>
									<div class="col-md-4 mb-4 mb-md-0">
										<label>Wohnungflache</label>
										<input type="text" placeholder="0 - 250">
									</div>
									<div class="col-md-4">
										<label>Erwachsene</label>
										<input type="text" placeholder="">
									</div>
								</div>
							</div>
							<div class="form_control">
								<div class="row">
									<div class="col-md-4 mb-4 mb-md-0">
										<label>Zimmer</label>
										<input type="text" placeholder="Egal">
									</div>
									<div class="col-md-4 mb-4 mb-md-0">
										<label>Was suchen sie?</label>
										<input type="text" placeholder="">
									</div>
									<div class="col-md-4">
										<label>Kinder</label>
										<input type="text" placeholder="">
									</div>
								</div>
							</div>
							<div class="form_control">
								<div class="row">
									<div class="col-md-4 mb-4 mb-md-0">
										<label>Wohnberechtigungsschein</label>
										<input type="text" placeholder="">
									</div>
									<div class="col-md-4 mb-4 mb-md-0">
										<label>Haustiere</label>
										<input type="text" placeholder="">
									</div>
									<div class="col-md-4">
										<label>Netto Haushaltseinkommen</label>
										<input type="text" placeholder="€">
									</div>
								</div>
							</div>
							<div class="action justify-content-center justify-content-md-end mt-md-5">
								<div class="default_btn"><a href="#" class="btn-filled">Weiter zur wohnungsuche</a></div>
								<div class="default_outline_btn"><a href="#" class="btn-outline">Dein dashboard</a></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 13.1 -meine daten contacten – 8 End-->

		<!-- 13.3 - neue wohnung – 9 start-->
		<div class="mydata white_bg" style="display:block;">
			<div class="container">
				<div class="back_btn"><a href="#" class="back-link"><i class="fa-solid fa-arrow-left"></i> Zur Übersicht</a></div>
				<h1 class="title">Inserat erstellen zu Vermietung einer Wohnung</h1>
				<div class="progress-container">
					<div class="progress_bar" style="width: 30%;"></div>
				</div>
				<div class="upload-section progress_form">
					<h2 class="mb-3">Fotos und Dokumenten zufügen:</h2>
					
					<div class="row align-items-start">
						<div class="upload-options d-flex flex-wrap gap-3">
							<div class="upload-card col align-items-center">
								<i class="fa-regular fa-image"></i>
								<div class="title">Bilder</div>
								<small>GIF, JPEG, PNG</small>
							</div>
							<div class="upload-card col">
								<i class="fa-solid fa-video"></i>
								<div class="title">Video, Max 1 GB</div>
								<small>MPG, AVI, MOV, MKV, MP4</small>
							</div>
							<div class="upload-card col">
								<i class="fa-solid fa-file"></i>
								<div class="title">Dokumenten</div>
								<small>PDF</small>
							</div>
							<div class="upload-card col">
								<i class="fa-solid fa-map"></i>
								<div class="title">Grundrisse</div>
								<small>GIF, JPEG, PNG, PDF</small>
							</div>
						</div>						
					</div>

					<div class="row align-items-start">
						<div class="col">
							<div class="uploaded-images d-flex gap-2 mt-3">
								<div class="image-box">
									<img src="/themes/template/images/image-placeholder.svg" alt="">
									<button class="delete-btn"><i class="fa-solid fa-trash"></i></button>
								</div>
								<div class="image-box">
									<img src="/themes/template/images/image-placeholder.svg" alt="">
									<button class="delete-btn"><i class="fa-solid fa-trash"></i></button>
								</div>
								<div class="image-box">
									<img src="/themes/template/images/image-placeholder.svg" alt="">
									<button class="delete-btn"><i class="fa-solid fa-trash"></i></button>
								</div>
							</div>
							<p class="mt-2 small_text">
								In die dokumenten dürfen keine personenbezogenen daten enthalten.<br>
								Namen, Adressen, Bankdaten von dritten enthalten.
							</p>
						</div>
						<div class="col-auto mt-3">
							<div class="tipp" style="max-width:260px;">
								<h3><i class="fa-regular fa-lightbulb"></i> Tipp:</h3>
								<div class="small_text">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut</div>
							</div>
						</div>
					</div>
					<div class="default_btn text-right"><a href="#">Weiter</a></div>
				</div>

			</div>
		</div>
		<!-- 13.3 - neue wohnung – 9 End-->

		<!-- 10.4 - Dashboard Suche speichern – 1 -->
		<div class="global_custom_form offer_popup white_100 width_1360" style="display:block;">
			<h2>Benachrichtigung</h2>
			<h3>Bestimmen Sie selbst, wie häufig und wie wir Ihnen neue Angebote senden</h3>
			<div class="row mt-5">
				<div class="col">
					<div class="area_label">Wie häufig</div>
					<div class="radio_group">
						<label class="radio-wrapper">
							<input type="radio" name="anrede"><span class="custom-radio"></span> In Echtzeit
						</label>
						<label class="radio-wrapper">
							<input type="radio" name="anrede"> <span class="custom-radio"></span> 1x täglich
						</label>
					</div>
				</div>
				<div class="col">
					<div class="area_label">Wie</div>
					<div class="radio_group">
						<div class="d-flex">
							<label class="radio-wrapper">
								<input type="radio" name="anrede"><span class="custom-radio"></span> E-mail
							</label>
						</div>
					</div>
				</div>
			</div>
			<div class="default_btn align_right">
				<a href="#">zur Bestätigung</a>
			</div>
		</div>
		<!-- 10.4 - Dashboard Suche speichern – 1-->

		<!-- 13.3 - neue wohnung – 11 start-->
		<div class="mydata white_bg" style="display:block;">
			<div class="container">
				<div class="back_btn"><a href="#" class="back-link"><i class="fa-solid fa-arrow-left"></i> Zur Übersicht</a></div>
				<h1 class="title">Inserat erstellen zu Vermietung einer Wohnung</h1>

				<div class="progress_form">
					<div class="progress-container">
						<div class="progress_bar" style="width: 30%;"></div>
					</div>
						<h2 class="mb-3">Bausubstanz und Energieausweis:</h2>
						<form>	
							<div class="row">
								<div class="col-md-6">
									<div class="form_control">
										<div class="row">
											<div class="col-md-6">
												<label>Objektzustand:</label>
											</div>
											<div class="col-md-6">
												<input type="text">
											</div>
										</div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form_control">
										<div class="row">
											<div class="col-md-6">
												<label>Heizungart:</label>
											</div>
											<div class="col-md-6">
												<input type="text">
											</div>
										</div>
									</div>
								</div>
							</div>

							<div class="row">
								<div class="col-md-6">
									<div class="form_control">
										<div class="row">
											<div class="col-md-6">
												<label>Letzte Modernisierung:</label>
											</div>
											<div class="col-md-6">
												<input type="text" placeholder="Datum">
											</div>
										</div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form_control">
										<div class="row">
											<div class="col-md-6">
												<label>Wesentlichter Energietrager:</label>
											</div>
											<div class="col-md-6">
												<input type="text">
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-6">
									<div class="form_control">
										<div class="row">
											<div class="col-md-6">
												<label>Wesentlichter Energietrager:</label>
											</div>
											<div class="col-md-6">
												<input type="text" placeholder="Datum">
											</div>
										</div>
									</div>
								</div>
							</div>
						
							<div class="default_btn text-right"><a href="#">Weiter</a></div>
						</form>
					</div>
				<script>
					document.querySelector('.progress_bar').classList.add('animate');
				</script>
			</div>
		</div>
		<!-- 13.3 - neue wohnung – 11 End-->

		<!-- 13.3 - neue wohnung – 19 start-->
		<div class="mydata white_bg progress_form" style="display:block;">
			<div class="container">
				<div class="row">
					<div class="col-md-6">
						<div class="back_btn"><a href="#" class="back-link"><i class="fa-solid fa-arrow-left"></i> Zur Übersicht</a></div>
						<h1 class="title">den Wohnungsstatus online!</h1>
						<div class="area_label">Behalten Sie Ihr Nachrichtenfeld im Auge.</div>
						<div class="tipp mt-5" style="max-width:586px;">
							<h3><i class="fa-regular fa-lightbulb"></i> Tipp:</h3>
							<div class="small_text">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laborisLorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo</div>
						</div>
					</div>
					<div class="col-md-6 mt-md-0 mt-5">
						<div class="image"><img src="/themes/template/images/for_rent_image.svg" alt=""></div>
					</div>
				</div>
			</div>
		</div>
		<!-- 13.3 - neue wohnung – 19 end-->

		<!-- 13.3 - neue wohnung – 10 start-->
		<div class="mydata white_bg progress_form">
			<div class="container">
				<div class="back_btn"><a href="#" class="back-link"><i class="fa-solid fa-arrow-left"></i> Zur Übersicht</a></div>
				<h1 class="title">Inserat erstellen zu Vermietung einer Wohnung</h1>
				<div class="progress_form contact_details_app">
					<div class="progress-container">
						<div class="progress_bar" style="width: 30%;"></div>
					</div>
					<h2>Kontaktdaten diese wohung*:</h2>
					<div class="d-flex gap-4 gap-md-5 mt-4 align-items-center">
						<div class="radio_group">
							<label class="radio-wrapper">
								<input type="radio" name="anrede"><span class="custom-radio"></span>
							</label>
						</div>
						<div class="landlord_head">
							<div class="header-left d-flex align-items-center gap-3">
								<img src="/themes/template/images/user_thumb.png" alt="User Thumb">
								<div class="content">
									<h4>Broker</h4>
									<div class="email"><i class="fa-solid fa-envelope"></i> E-mail: Loremipsum@mail.de</div>
									<div class="phone"><i class="fa-solid fa-phone"></i> Tel: 06-123456789</div>
								</div>
							</div>
						</div>
					</div>
					<div class="d-flex gap-4 gap-md-5 mt-4 align-items-center">
						<div class="radio_group">
							<label class="radio-wrapper">
								<input type="radio" name="anrede"><span class="custom-radio"></span>
							</label>
						</div>
						<div class="landlord_head">
							<div class="header-left d-flex align-items-center gap-3">
								<img src="/themes/template/images/user_thumb.png" alt="User Thumb">
								<div class="content">
									<h4>Broker</h4>
									<div class="email"><i class="fa-solid fa-envelope"></i> E-mail: Loremipsum@mail.de</div>
									<div class="phone"><i class="fa-solid fa-phone"></i> Tel: 06-123456789</div>
								</div>
							</div>
						</div>
					</div>
					<div class="d-flex gap-4 gap-md-5 mt-4 align-items-center">
						<div class="radio_group">
							<label class="radio-wrapper">
								<input type="radio" name="anrede"><span class="custom-radio"></span>
							</label>
						</div>
						<div class="landlord_head">
							<div class="header-left d-flex align-items-center gap-3">
								<img src="/themes/template/images/user_thumb.png" alt="User Thumb">
								<div class="content">
									<h4>Broker</h4>
									<div class="email"><i class="fa-solid fa-envelope"></i> E-mail: Loremipsum@mail.de</div>
									<div class="phone"><i class="fa-solid fa-phone"></i> Tel: 06-123456789</div>
								</div>
							</div>
						</div>
					</div>
					<div class="d-flex gap-4 gap-md-5 mt-4 align-items-center">
						<div class="radio_group">
							<label class="radio-wrapper">
								<input type="radio" name="anrede"><span class="custom-radio"></span>
							</label>
						</div>
						<div class="landlord_head">
							<div class="header-left d-flex align-items-center gap-3">
								<img src="/themes/template/images/user_thumb.png" alt="User Thumb">
								<div class="content">
									<h4>Broker</h4>
									<div class="email"><i class="fa-solid fa-envelope"></i> E-mail: Loremipsum@mail.de</div>
									<div class="phone"><i class="fa-solid fa-phone"></i> Tel: 06-123456789</div>
								</div>
							</div>
						</div>
					</div>
					<div class="default_btn text-right"><a href="#">Weiter</a></div>
				</div>
			</div>
		</div>
		<!-- 13.3 - neue wohnung – 10 end-->


		<!-- 13.3 - neue wohnung – 12 start-->
		<div class="mydata white_bg" style="display:block;">
			<div class="container">
				<div class="back_btn"><a href="#" class="back-link"><i class="fa-solid fa-arrow-left"></i> Zur Übersicht</a></div>
				<h1 class="title">Inserat erstellen zu Vermietung einer Wohnung</h1>
				<div class="progress_form">
					<div class="progress-container">
						<div class="progress_bar" style="width: 90%;"></div>
					</div>
					<h2>Bausubstanz und Energieausweis:</h2>
					<div class="row">
						<div class="col">
							<div class="d-md-flex mt-4">
								<div class="area_label col-md-6">Energieausweis liegt zur Besigtigung vor:</div>
								<div class="radio_group  col-md-6">
									<div class="d-flex gap-5">
										<label class="radio-wrapper inline-wrapper">
											<input type="radio" name="anrede"><span class="custom-radio"></span> Ja
										</label>
										<label class="radio-wrapper inline-wrapper">
											<input type="radio" name="anrede"> <span class="custom-radio"></span> Nein
										</label>
									</div>
								</div>
							</div>
							<div class="d-md-flex mt-4">
								<div class="area_label col-md-6">Dieses Gebaude unterliegt den Anforderungen de GEG:</div>
								<div class="radio_group col-md-6">
									<div class="d-flex gap-5">
										<label class="radio-wrapper inline-wrapper">
											<input type="radio" name="anrede"><span class="custom-radio"></span> Ja
										</label>
										<label class="radio-wrapper inline-wrapper">
											<input type="radio" name="anrede"> <span class="custom-radio"></span> Nein
										</label>
									</div>
								</div>
							</div>
							<div class="d-md-flex mt-4">
								<div class="area_label col-md-6">Energieausweis liegt vor:</div>
								<div class="radio_group col-md-6">
									<div class="d-flex gap-5">
										<label class="radio-wrapper inline-wrapper">
											<input type="radio" name="anrede"><span class="custom-radio"></span> Ja
										</label>
										<label class="radio-wrapper inline-wrapper">
											<input type="radio" name="anrede"> <span class="custom-radio"></span> Nein
										</label>
									</div>
								</div>
							</div>
							<small class="col-md-6 mt-3">Das Gebaudeenergiegestelz GEG 2020 schreibt vor: Alle relevanten Angaben aus dem Energieausweis vorzulegen sind. Spatestens bei der Besigtigung ist der Energieausweis unaufgevordert vorzuzueigen. Energieausweise ahben eine Gultigkeit van 10 jahren.</small>
						</div>
						<div class="col-auto">
							<div class="tipp mt-5" style="max-width:260px;">
								<h3><i class="fa-regular fa-lightbulb"></i> Tipp:</h3>
								<div class="small_text">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi</div>
							</div>
						</div>
					</div>
					<h3 class="mt-4">API-Suchfelder</h3>
					<div class="btn_group d-flex gap-5">
						<div class="default_btn"><a href="#">Vorschau ansehn</a></div> <div class="default_btn"><a href="#">Wohnung anmelden</a></div>
					</div>

					<div class="default_btn text-right mt-5"><a href="#">Weiter</a></div>

				</div>
			</div>
		</div>
		<!-- 13.3 - neue wohnung – 12 end-->
		

<% include Footer %>

<% include MainFooter %>