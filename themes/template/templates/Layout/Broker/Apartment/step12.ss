<% include MainHeader %>

<% include Header %>

<% include DashboardHeader %>
<h1>$Title</h1>
	<div class="progress_form">
					<div class="progress-container">
						<div class="progress_bar" style="width: 92.28%;"></div>
					</div>
<form $Form.AttributesHTML>
<input type='hidden' name='preview' value='$preview' />
		<h2>Bausubstanz und Energieausweis:</h2>
					<div class="row">
						<div class="col">
							<div class="d-md-flex mt-4">
								$Energieausweis
							</div>
							<div class="d-md-flex mt-4">
								$Dieses
							</div>
							<div class="d-md-flex mt-4">
								$EnergieausweisVor
							</div>
							<small class="col-md-6 mt-3">Das Gebaudeenergiegestelz GEG 2020 schreibt vor: Alle relevanten Angaben aus dem Energieausweis vorzulegen sind. Spatestens bei der Besigtigung ist der Energieausweis unaufgevordert vorzuzueigen. Energieausweise ahben eine Gultigkeit van 10 jahren.</small>
						</div>
						<div class="col-auto">
							<div class="tipp mt-5" style="max-width:260px;">
								<h3><i class="fa-regular fa-lightbulb"></i> Tipp:</h3>
								<div class="small_text">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi</div>
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