
		<% include MainHeader %>

	<% include Header %>
        <!--Deine gespeicherte suche start-->
		<div class="mydata white_bg" style="display:block;">
			<div class="container">
				<div class="back_btn"><a href="/dashboard" class="back-link"><i class="fa-solid fa-arrow-left"></i> Zur Übersicht</a></div>
				<h1 class="title">$Title</h1>
                <% if $subcriptions %>
				<%  loop $subcriptions %>
				<div class="row">
					<div class="col-12 col-sm-9">Abrechnung $FromDate to $ToDate</div>
					<div class="col-12 col-sm-3"><div class="default_btn"><a href="/invoices/download/$ID">Download</a></div></div>
				</div>
                <% end_loop %>
                <% else %>
             	<div class="alert alert-primary" role="alert">
					No Invoice Found
				</div>
                <% end_if %>
				
				
			</div>
		</div>

	<% include Footer %>

<% include MainFooter %>
		<!--Deine gespeicherte suche End-->