<% include MainHeader %>

	<% include Header %>

		<div class="login_dashboard">
			<div class="container">
				<div class="user_name">Hallo<br> $Name</div>
				<div class="dashboard_cards">
					<h2>alle Informationen auf einen Blick</h2>
					<div class="cards">
						<a href="/dashboard/info/">
							<div class="icon"><i class="fa-solid fa-user"></i></div>
							<div class="text">
								<h3>Alle ihre gegevens</h3>
								<p>Ein ubersicht von alle benachrichtigte wohnungen</p>
							</div>
						</a>
					</div>
					<div class="cards">
						<a href="/dashboard/brokerapartments">
							<div class="icon"><i class="fa-solid fa-house"></i></div>
							<div class="text">
								<h3>Alle ihre wohnungen</h3>
								<p>alle Ihre angebotenen Wohnungen ansehen</p>
							</div>
						</a>
					</div>
					<div class="cards">
						<a href="/apartment/step1">
							<div class="icon"><i class="fa-solid fa-house-plus"></i></div>
							<div class="text">
								<h3>Neue wohnung anb.</h3>
								<p>Biete neue Wohnung</p>
							</div>
						</a>
					</div>
					<div class="cards">
						<a href="/dashboard/applications/">
							<div class="icon"><i class="fa-solid fa-message-dots"></i></div>
							<div class="text">
								<h3>anhängige Anträge</h3>
								<p>Alle nachrichten</p>
							</div>
						</a>
					</div>
					<div class="cards">
						<a href="/dashboard/subscription/">
							<div class="icon"><i class="fa-solid fa-star"></i></div>
							<div class="text">
								<h3>Abonnoment</h3>
								<p>Nog sneller verhuren</p>
							</div>
						</a>
					</div>
					<div class="cards">
						<a href="/dashboard/tips/">
							<div class="icon"><i class="fa-solid fa-lightbulb"></i></div>
							<div class="text">
								<h3>Tips</h3>
								<p>Alle diene Dokumente an einem platz</p>
							</div>
						</a>
					</div>
				</div>
				<div class="default_btn"><a href="/Security/logout">Ausloggen</a></div>

			</div>
		</div>

<% include Footer %>

<% include MainFooter %>