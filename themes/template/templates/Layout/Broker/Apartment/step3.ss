<% include MainHeader %>

<% include Header %>

<% include DashboardHeader %>
<h1>$Title</h1>


	<div class="progress_form">
					<div class="progress-container">
						<div class="progress_bar" style="width: 23.07%;"></div>
					</div>
                    <h2 class="mb-3">Echdaten:</h2>
<form $Form.AttributesHTML>
<input type='hidden' name='preview' value='$preview' />
<div class="row">
<div class="col-md-6">
	<div class="form_control">
										<div class="row">
											<div class="col-md-6">
												<label>$Wohnflache.Title:</label>
											</div>
											<div class="col-md-6">
												<div class="input-group">
													$Wohnflache
													<span class="input-group-text">m²</span>
												</div>
											</div>
										</div>
									</div>
                                    	<div class="form_control">
										<div class="row">
											<div class="col-md-6">
												<label>$Kaltmiete.Title:</label>
											</div>
											<div class="col-md-6">
												<div class="input-group">
													$Kaltmiete
													<span class="input-group-text">Euro</span>
												</div>
											</div>
										</div>
									</div>
                                    	<div class="form_control">
										<div class="row">
											<div class="col-md-6">
												<label>$Nebenkosten.Title:</label>
											</div>
											<div class="col-md-6">
												<div class="input-group">
													$Nebenkosten
													<span class="input-group-text">Euro</span>
												</div>
											</div>
										</div>
									</div>
                                    <div class="area_label">Heizunkosten in Nebenkosen:</div>
									<div class="form_control">
										<div class="row">
											<div class="col-md-6">
												<label>$Gesamtmiete.Title:</label>
											</div>
											<div class="col-md-6">
												<div class="input-group">
													$Gesamtmiete
													<span class="input-group-text">Euro</span>
												</div>
											</div>
										</div>
									</div>
</div>
<div class="col-md-6">
<div class="form_control">
										<div class="row">
											<div class="col-md-6">
												<label>$Zimmer.Title:</label>
											</div>
											<div class="col-md-6">
												<div class="input-group">
													$Zimmer
												</div>
											</div>
										</div>
									</div>
                                    	<div class="form_control">
										<div class="row">
											<div class="col-md-6">
												<label>$FloorVerfugbarAb.Title:</label>
											</div>
											<div class="col-md-6">
												<div class="input-group">
													$FloorVerfugbarAb
													
												</div>
											</div>
										</div>
									</div>
									<div class="form_control">
										<div class="row">
											<div class="col-md-6">
												<label>$Kaution.Title:</label>
											</div>
											<div class="col-md-6">
												<div class="input-group">
													$Kaution
												</div>
											</div>
										</div>
									</div>
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
					
