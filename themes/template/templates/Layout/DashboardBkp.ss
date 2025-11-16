<% include MainHeader %>

	<% include Header %>

		<div class="login_dashboard" style="display:none;">
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
		
		<div class="white_card" style="display:none;">
			<div class="container">
				<h2>Email-adresse controlle</h2>
				<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Non pulvinar neque laoreet suspendisse interdum consectetur libero id faucibus. Faucibus nisl tincidunt eget nullam non nisi est sit. Pellentesque habitant morbi tristique senectus. Tortor dignissim convallis aenean et tortor at risus viverra adipiscing. Vulputate eu scelerisque felis imperdiet. Turpis egestas maecenas pharetra convallis. Eget egestas purus viverra accumsan in nisl nisi. Amet mauris commodo quis imperdiet massa tincidunt nunc. Sit amet porttitor eget dolor morbi non arcu risus. Lorem ipsum dolor sit amet consectetur adipiscing.</p>
				<div class="button_group">
					<a href="#" class="yellow_btn">andere E-Mail</a> <a class="outline_btn" href="#">andere E-Mail</a>
				</div>
			</div>
		</div>


		<%-- Persönliche Angaben --%>
		<div class="global_custom_form white_100 width_1360" style="display:none;">
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
		<div class="global_custom_form white_100 width_1360 pl_60 pr_60" style="display:none;">
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
		<div class="mydata white_bg" style="display:none;">
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
		<div class="mydata white_bg favorite_list project_list_view" style="display:none">
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
		<!--Deine favoriten wohnungen end-->

		<!--Nachrichten start-->
		<div class="mydata white_bg news" style="display:none;">
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
		<div class="mydata white_bg" style="display:none;">
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
				<div class="project_list_view favorite_list">
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

		<div class="mydata white_bg rental_professional">
			<div class="container">
				<div class="back_btn"><a href="#" class="back-link"><i class="fa-solid fa-arrow-left"></i> Zur Übersicht</a></div>
				<h1 class="title">Mietenprofi</h1>
				<div class="plans-wrapper">
					<div class="plan-box">
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
							<div class="icon"><i class="fa-solid fa-building"></i></div>
							<div class="month">1 Monate</div>
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
							<div class="icon"><i class="fa-solid fa-house"></i></div>
							<div class="month">3 Monate</div>
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
							<div class="icon"><i class="fa-solid fa-building-columns"></i></div>
							<div class="month">6 Monate</div>
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

<% include Footer %>

<% include MainFooter %>