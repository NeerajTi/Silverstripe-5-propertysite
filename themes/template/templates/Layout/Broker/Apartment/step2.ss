<% include MainHeader %>

<% include Header %>

<% include DashboardHeader %>
<h1>$Title</h1>
<div class="progress_form">
	<div class="progress-container">
		<div class="progress_bar" style="width: 15.38%;"></div>
	</div>
<form $Form.AttributesHTML>
<div class="address_form">
<h3>Adresse:</h3>
<div class="form_control d-flex">
<label for="Street" class="left_side hide-on-mobile">$Street.Title:</label>
<div class="row">
								<div class="col-md-10 col-9">
									<label class="show-on-mobile">$Street.Title:</label>
									$Street
								</div>
								<div class="col-md-2 col-3">
									<div class="d-md-flex align-items-center gap-15">
										<label>$Nr.Title:</label>
										$Nr
									</div>
								</div>
							</div>
</div>
<div class="form_control d-flex">
							<label class="left_side hide-on-mobile">$Plz.Title:</label>
							<div class="row">
								<div class="col-md-2 col-3">
									<label class="show-on-mobile">$Plz.Title:</label>
									$Plz
								</div>
								<div class="col-md-10 col-9">
									<div class="d-md-flex align-items-center gap-15">
										$StrasseundHausnummer
									</div>
								</div>
							</div>
						</div>
							
							<div class="form_control d-flex">
							<label class="left_side">$Stadt.Title:</label>
							<div class="row">
								<div class="col-md-4">
									$Stadt
								</div>
								<div class="col-md-8 mobile-mt-10">
									<div class="d-md-flex align-items-center gap-15 justify-right justify-content-between">
										<label>$Stadtteil.Title:</label>
										$Stadtteil
									</div>
								</div>
							</div>
						</div>

                   
                               <div class="default_btn text-right">
                                    $Form.Actions
                                </div>
</div>
                </form>
</div>
<% include DashboardFooter %>

<% include Footer %>

<% include MainFooter %>