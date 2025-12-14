
		<% include MainHeader %>

	<% include Header %>
        <!--Deine gespeicherte suche start-->
		<div class="mydata white_bg" style="display:block;">
			<div class="container">
				<div class="back_btn"><a href="/renter-dashboard" class="back-link"><i class="fa-solid fa-arrow-left"></i> Zur Übersicht</a></div>
				<h1 class="title">Deine gespeicherte suche</h1>
				<div class="saved_search_card">
					
					<div class="notification">
						
						<div class="actions">
						
							<div class="default_btn"><a href="javascript:void(0)" data-redirect-url="/renter-dashboard/saved-search" data-alert-msg="Are you sure want to delete saved search?" class="delete-account-btn" data-action-url="/renter-dashboard/remove_saved_search">Gespeicherte Suche löschen</a></div>
						</div>
					</div>
				</div>
				<div class="saved_search_card">
					<div class="criteria">Preis max: 1400 euro, Kaltmiete, Wohnungflache min: 60m², Anzahl zimmer: Egal</div>
					<div class="notification">
						<div class="left_card">
							<label class="switch">
								<input type="checkbox" class="notification-toggle" <% if $MemberBasicData.Notification1==1 %>checked<% end_if %> data-notification="1">
								<span class="slider round"></span>
							</label>
							<div class="text"><span>Benachrichtigung</span> <% if $MemberBasicData.Notification1==1 %>Aktiv<% else %>Inaktiv<% end_if %></div>
						</div>
						<div class="actions">
							<div class="result-count">$countNotification1 Wohnungen</div>
							<div class="default_btn"><a href="/stadtteile-berlins/?price=1400&space=60">Wohnungen ansehen</a></div>
						</div>
					</div>
				</div>
				<div class="saved_search_card">
					<div class="criteria">Preis max: 1400 euro, Kaltmiete, Wohnfläche min: 60m², Anzahl Zimmer: Egal, Was suchen sie?: Wohnung, Haustiere: Erlaubt</div>
					<div class="notification">
						<div class="left_card">
							<label class="switch">
								<input type="checkbox" class="notification-toggle" <% if $MemberBasicData.Notification2==1 %>checked<% end_if %> data-notification="2">
								<span class="slider round"></span>
							</label>
							<div class="text"><span>Benachrichtigung</span> <% if $MemberBasicData.Notification2==1 %>Aktiv<% else %>Inaktiv<% end_if %></div>
						</div>
						<div class="actions">
							<div class="result-count">$countNotification2 Wohnungen</div>
							<div class="default_btn"><a href="/stadtteile-berlins/?price=1400&space=60&equipment=Haustiere+erlaubt">Wohnungen ansehen</a></div>
						</div>
					</div>
				</div>
				<div class="project_list_view favorite_list" style="display:block; ">
					<h2>die 20 neuesten Uploads in Ihren Suchen</h2>
                    <% if $Apartments %>
                    <% include PropertyList %>
                    <% else %>
                    <div class="alert alert-info">No apartments found as per your search criteria</div>
                    <% end_if %>
				
				</div>
			</div>
		</div>

	<% include Footer %>

<% include MainFooter %>
		<!--Deine gespeicherte suche End-->