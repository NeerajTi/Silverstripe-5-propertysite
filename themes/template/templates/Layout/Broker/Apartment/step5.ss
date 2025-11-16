<% include MainHeader %>

<% include Header %>

<% include DashboardHeader %>

<h1>$Title</h1>
<div class="progress_form">
					<div class="progress-container">
						<div class="progress_bar" style="width:38.45%;"></div>
					</div>
<form $Form.AttributesHTML>
<h2>Details:</h2>
<div class="area_label" style='font-weight: bold'>Anzahl voorzieningen:</div>
	<div class="row">
								<div class="col-xl-6 col-md-12">
									<div class="form_control">
										<div class="row">
											<div class="col-md-6">
												<label>$Schlafzimmer.Title:</label>
											</div>
											<div class="col-md-6">$Schlafzimmer</div>
										</div>
									</div>	
								</div>

								<div class="col-xl-6 col-md-12">
									<div class="form_control">
										<div class="row">
											<div class="col-md-6">
												<label> $Badezimmer.Title:</label>
											</div>
											<div class="col-md-6">$Badezimmer</div>
										</div>
									</div>
								</div>
							</div>

							<div class="row">
								<div class="col-xl-6 col-md-12">
									<div class="form_control">
										<div class="row">
											<div class="col-md-6">
												<label>$Etage.Title:</label>
											</div>
											<div class="col-md-6 d-flex align-items-end gap-4">
												$Etage
												<label>$Von.Title:</label> $Von
											</div>
										</div>
									</div>
								</div>

								<div class="col-xl-6 col-md-12">
									<div class="form_control">
										<div class="row">
											<div class="col-md-6">
												<label>$Nutzflache.Title:</label>
											</div>
											<div class="col-md-6">
												<div class="input-group">
													$Nutzflache
													<span class="input-group-text">m²</span>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
                            	<div class="row mt-3 radio_btn_list">
								<div class="col-md-6">
									<label class="area_label mb-3">Wohnberechtigungsscein:</label>
                                    $Wohnberechtigungsschein
								</div>
								<div class="col-md-6">
									<label class="area_label mb-3">Heizungart:</label>
								$Heizungsart
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