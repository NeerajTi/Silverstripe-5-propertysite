<% include MainHeader %>

<% include Header %>

<% include DashboardHeader %>
<h1>$Title</h1>
	<div class="progress_form radio_btn_list">
					<div class="progress-container">
						<div class="progress_bar" style="width: 46.14%;"></div>
					</div>
<form $Form.AttributesHTML>
<h2 class="mb-3">Details:</h2>
<div class="row g-1 g-md-5">
								<div class="col-md-4">

$Internetgeschwindigkeit
</div>
<div class="col-md-4">

$Energieeffiziezklasse
</div>
<div class="col-md-4">
 <div class="tipp" style="max-width:260px;">
										<h3><i class="fa-regular fa-lightbulb"></i> Tipp:</h3>
										<div class="small_text">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et</div>
									</div>
</div>
</div>
                                <div class="default_btn text-right">
                                    $Form.Actions
                                </div>
</form>
</div>
<% include DashboardFooter %>

<% include Footer %>

<% include MainFooter %>