<% include MainHeader %>

<% include Header %>

<% include DashboardHeader %>
<h1>$Title</h1>
				<div class="progress_form">
					<div class="progress-container">
						<div class="progress_bar" style="width: 53.83%;"></div>
					</div>
						<h2 class="mb-3">Beschreibungen:</h2>
					<form $Form.AttributesHTML>
					<input type='hidden' name='preview' value='$preview' />
							<div class="area_label">$Uberschrift.Title:</div>
							<div class="row align-items-start">
								<div class="col">
									<div class="textarea textarea_global">
										$Uberschrift
										
									</div>
								</div>
								<div class="col-auto mt-4 mt-md-0">
									<div class="tipp" style="max-width:260px;">
										<h3><i class="fa-regular fa-lightbulb"></i> Tipp:</h3>
										<div class="small_text">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut</div>
									</div>
								</div>
							</div>
						
							<div class="default_btn text-right mt-5"> $Form.Actions</div>
						</form>
					</div>

<% include DashboardFooter %>

<% include Footer %>

<% include MainFooter %>