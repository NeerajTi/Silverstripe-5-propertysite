<% include MainHeader %>

<% include Header %>

<% include DashboardHeader %>
<h1>$Title</h1>
<div class="progress_form">
					<div class="progress-container">
						<div class="progress_bar" style="width:84.59%;"></div>
					</div>
<form $Form.AttributesHTML>
		<div class="row">
								<div class="col-md-6">
									<div class="form_control">
										<div class="row">
											<div class="col-md-6">
												<label>$Objektzustand.Title:</label>
											</div>
											<div class="col-md-6">
												$Objektzustand
											</div>
										</div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form_control">
										<div class="row">
											<div class="col-md-6">
												<label>$Heizungart.Title:</label>
											</div>
											<div class="col-md-6">
												$Heizungart
											</div>
										</div>
									</div>
								</div>
							</div>

							<div class="row">
								<div class="col-md-6">
									<div class="form_control">
										<div class="row">
											<div class="col-md-6">
												<label>$LetzteModernisierung.Title:</label>
											</div>
											<div class="col-md-6">
												$LetzteModernisierung
											</div>
										</div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form_control">
										<div class="row">
											<div class="col-md-6">
												<label>$WesentlichterEnergietrager.Title:</label>
											</div>
											<div class="col-md-6">
												$WesentlichterEnergietrager
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-6">
									<div class="form_control">
										<div class="row">
											<div class="col-md-6">
												<label>$BaujahrDesGebaudes.Title:</label>
											</div>
											<div class="col-md-6">
												$BaujahrDesGebaudes
											</div>
										</div>
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