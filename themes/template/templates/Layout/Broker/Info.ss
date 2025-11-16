<% include MainHeader %>

	<% include Header %>

		<div class="mydata white_bg">
			<div class="container">
				<div class="user_name user_info">Hallo<br> $Name</div>
				<div class="back_btn"><a href="javascript:void(0);" onclick="window.history.back();" class="back-link"><i class="fa-solid fa-arrow-left"></i> Zur Übersicht</a></div>
				<h1 class="title">Meine Daten</h1>
				<div class="profile-card">
					<div class="profile-info">
						<div class="profile-icon">
						<% if $userType == 'owner' || $userType == 'seller' %>
							<% if $PersonalInformation.Bilder %>
								<img src="$PersonalInformation.Bilder.URL" alt="User Thumb">
							<% else %>
								<img src="/themes/template/images/user_thumb.png" alt="User Thumb">
							<% end_if %>
						<% else %>
							<% if $Company.Image %>
								<img src="$Company.Image.URL" alt="User Thumb">
							<% else %>
								<img src="/themes/template/images/user_thumb.png" alt="User Thumb">
							<% end_if %>
						<% end_if %>
						</div>
						<div class="profile_text">
							<h2>$Name</h2>
							<p><% if $Company.Website %><a href="$Company.Website" target="_blank">$Company.Website</a><% end_if %></p>
						</div>
					</div>
					<div class="profile-status hide-on-mobile">
						<span><a href="/stadtteile-berlins/list/$BrokerAptSlug"><i class="fa-solid fa-eye"></i> Inidkator für offene Profile</a></span>
					</div>
				</div>

				<div class="column-wrapper">
					<div class="left-column">
						<div class="info-block">
							<a href="/dashboard/updateinfo/">
								<h3>Selbstauskunft</h3>
								<p>um zu sehen</p>
							</a>
						</div>
						<% if $userType=='broker' %>
						<div class="info-block">
							<a href="/dashboard/brokercontacts/">
								<h3>Broker-Informationen</h3>
								<p>um zu sehen</p>
							</a>
						</div>
						<% end_if %>
					
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
							<a href="javascript:void(0)" class="delete-account-btn" data-action-url="/dashboard/delete-account">
								<h3>Konto löschen <span><i class="fa-solid fa-trash"></i></span></h3>
								
							</a>
						</div>
					
					</div>

					<div class="profile-status show-on-mobile">
						<span><a href="/stadtteile-berlins/list/$BrokerAptSlug"><i class="fa-solid fa-eye"></i> Inidkator für offene Profile</a></span>
					</div>

					<div class="right-column hide-on-mobile">
						<div class="font-opacity-70">RECLAME <br>BVB ABONOMENT</div>
					</div>
				</div>
			</div>
		</div>

	<% include Footer %>

<% include MainFooter %>