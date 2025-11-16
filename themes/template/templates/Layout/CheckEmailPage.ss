<% include MainHeader %>

<% include Header %>

<div class="white_card pb-30">
	<div class="container">
		<h2>Email-adresse controlle</h2>
		<p>Wenn du keine Mail empfangen hast, schaue in deinem Spam Ordner nach</p>
		
		<% if $FormError %>
            <div class="alert alert-danger">
                $FormError
            </div>
        <% end_if %>
        <% if $FormSuccess %>
            <div class="alert alert-success">
                $FormSuccess
            </div>
        <% end_if %>
		<div class="button_group">
			<a href="/registration/" class="yellow_btn">andere E-Mail</a> <a class="outline_btn" href="/registration/resendemail/$TempIDHash">kein Code erhalten</a>
		</div>
	</div>
</div>

<% include Footer %>

<% include MainFooter %>