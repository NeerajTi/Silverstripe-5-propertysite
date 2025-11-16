<% include MainHeader %>

	<% include Header %>

		<div class="white_card">
			<div class="container">
				<h2>Konto erstellt</h2>
				<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Non pulvinar neque laoreet suspendisse interdum consectetur libero id faucibus. Faucibus nisl tincidunt eget nullam non nisi est sit. Pellentesque habitant morbi tristique senectus. Tortor dignissim convallis aenean et tortor at risus viverra adipiscing. Vulputate eu scelerisque felis imperdiet. Turpis egestas maecenas pharetra convallis. Eget egestas purus viverra accumsan in nisl nisi. Amet mauris commodo quis imperdiet massa tincidunt nunc. Sit amet porttitor eget dolor morbi non arcu risus. Lorem ipsum dolor sit amet consectetur adipiscing.</p>
				<div class="check_icon"><img src="/themes/template/images/check_icon.png" alt="Thanks"></div>
				<div class="button_group">
				<% if $InseriereAls == 'broker' %><a class="outline_btn" href="/dashboard/brokercontacts/">Vermieter hinzufugen</a><% end_if %><a href="/apartment/step1" class="yellow_btn">Upload Wohnung</a> <a class="outline_btn" href="/dashboard">Dein dashboard</a>
				</div>
			</div>
		</div>

	<% include Footer %>
	
<% include MainFooter %>