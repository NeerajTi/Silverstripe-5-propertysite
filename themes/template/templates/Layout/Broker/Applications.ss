	<% include MainHeader %>

	<% include Header %>

<input type="hidden" name="SecurityID" value="$SecurityID">
    <div class="mydata white_bg news">
			<div class="container">
				<div class="back_btn"><a href="/dashboard/" class="back-link"><i class="fa-solid fa-arrow-left"></i> Zur Übersicht</a></div>
				<h1 class="title">$Title</h1>
				<% if $Applications %>
                <% loop $Applications %>
				<div class="abo-card">
                <% if $Apartment.Bilder.Exists %>
                <div class="abo-image hide-on-mobile hide-on-ipad"><img src="$Apartment.Bilder.First.Fill(400,300).URL" alt="Greifenhagener Thumb"></div>
                <% else %>
                <div class="abo-image hide-on-mobile hide-on-ipad"><img src="/themes/template/images/image-placeholder.svg" alt=""></div>
                <% end_if %>
					<div class="abo-content">
						<h2>es besteht Interesse</h2>
						<p class="date-time">$CreatedDate</p>
						<p class="description">$SubDescription…</p>
					</div>
					<div class="abo-actions">
					<a class="remove-global-any" style="color:#D98209;cursor:pointer" data-redirect-url="/dashboard/applications" data-alert-msg="Möchten Sie diese Anwendung wirklich löschen?" data-action-url="/dashboard/removeapplication" href="javascript:void(0);" data-object-id="$ID"><i class="fa-solid fa-trash"></i></a>
						<div class="menu-dots hide-on-mobile"><a href="/dashboard/application-detail/$ID"><i class="fa-solid fa-ellipsis-vertical"></i></a></div>
						
						<div class="default_btn">
						
						<a href="/dashboard/application-detail/$ID">
						<% if $IsRead == 0 %>
						<i class="fa-solid fa-envelope"></i>
						<% end_if %>
						um zu sehen</a></div>
					</div>
				</div>
                <% end_loop %>
				<% else %>
				<div class="alert alert-primary" role="alert">
					Keine Anfragen vorhanden
				</div>
				<% end_if %>
			</div>
		</div>

        	<% include Footer %>

<% include MainFooter %>