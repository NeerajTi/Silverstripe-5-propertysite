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
						<% if $PersonalInformation.Bilder %>
							<img src="$PersonalInformation.Bilder.URL" alt="User Thumb">
						<% else %>
							<img src="/themes/template/images/user_thumb.png" alt="User Thumb">
						<% end_if %>
						</div>
						<div class="profile_text">
							<h2>$PersonalInformation.FirstName $PersonalInformation.LastName</h2>
							<p>$PersonalInformation.Email</p>
						</div>
					</div>
				</div>

				<div class="column-wrapper">
					<div class="left-column">
						<div class="info-block">
							<a href="/renter-dashboard/updateinfo/">
								<h3>Selbstauskunft</h3>
								<p>um zu sehen</p>
							</a>
						</div>
						<div class="info-block add">
							<a href="#;">
								<h3>Bonitätsauskunft <span><i class="fa-solid fa-plus"></i></span></h3>
								<p>Erstellen</p>
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
						<div class="info-block add">
							<a href="javascript:void(0)" class="delete-account-btn" data-action-url="/renter-dashboard/remove_account">
								<h3>Konto löschen <span><i class="fa-solid fa-trash"></i></span></h3>
								
							</a>
						</div>
					</div>

					<div class="right-column">
						<div class="font-opacity-70">RECLAME <br>BVB ABONOMENT</div>
					</div>
				</div>
			</div>
		</div>

	<% include Footer %>

<% include MainFooter %>