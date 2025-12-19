<% include MainHeader %>

<% include Header %>

<% include DashboardHeader %>
<h1>$Title</h1>
	<div class="progress_form radio_btn_list">
					<div class="progress-container">
						<div class="progress_bar" style="width: 30.76%;"></div>
					</div>
<form $Form.AttributesHTML>
<input type='hidden' name='preview' value='$preview' />
<div class="row">
<div class="col-12 col-md-7">
<h2>Details:</h2>
$DetailsOptions
</div>
<div class="col-12 col-md-4 offset-md-1">
<h3>Qualitat der Wohnung:</h3>
$QualitatDerWohnung
</div>

                                <div class="default_btn text-right">
                                    $Form.Actions
                                </div>
</form>
</div>
<% include DashboardFooter %>

<% include Footer %>

<% include MainFooter %>