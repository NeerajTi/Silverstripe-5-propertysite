	<% include MainHeader %>

	<% include Header %>
    <div class="mydata white_bg" style="display:block;">
			<div class="container">
				<div class="progress_form">
					<div class="row align-items-center">
						<div class="col-xl-5 col-md-12">
							<div class="image text-center"><img src="/themes/template/images/Mail-sent-rafiki.svg" alt=""></div>
						</div>
						<div class="col-xl-7 col-md-12">
							<h2 class="mb-3">Danke! <br>Ihre Nachricht wurde gesendet</h2>
							<div class="row">
								<div class="col-md-8">
									<div class="form_control">
										<label>Nachricht</label>
										<div class="filled_textarea">$data.Description</div>
									</div>
								</div>
								<div class="col-md-4">
									<div class="form_control">
										<label>Stadtteil</label>
										<div class="filled_input">$data.Stadtteil</div>
									</div>
									<div class="radio_group form_control">
										<label class="form-label left_side">SCHUFA - BonitätsCheck</label>
										<label class="radio-wrapper">
                                        <% if $data.CreditCheck=='Ja' %>
                                            <input type="radio" name="anrede" checked><span class="custom-radio"></span> Ja
                                        <% else %>
                                            <input type="radio" name="anrede" checked><span class="custom-radio"></span> Nein
                                        <% end_if %>
										</label>
									</div>
								</div>
							</div>
							<div class="form_control">
								<div class="row">
									<div class="col-md-4 mb-4 mb-md-0">
										<label>Preis</label>
										<div class="filled_input">$data.Preis</div>
									</div>
									<div class="col-md-4 mb-4 mb-md-0">
										<label>Wohnungflache</label>
										<div class="filled_input">$data.Wohnungflache</div>
									</div>
									<div class="col-md-4">
										<label>Erwachsene</label>
										<div class="filled_input">$data.Erwachsene</div>
									</div>
								</div>
							</div>
							<div class="form_control">
								<div class="row">
									<div class="col-md-4 mb-4 mb-md-0">
										<label>Zimmer</label>
										<div class="filled_input">$data.Zimmer</div>
									</div>
									<div class="col-md-4 mb-4 mb-md-0">
										<label>Was suchen sie?</label>
										<div class="filled_input">$data.lookingfor</div>
									</div>
									<div class="col-md-4">
										<label>Kinder</label>
										<div class="filled_input">$data.Kinder</div>
									</div>
								</div>
							</div>
							<div class="form_control">
								<div class="row">
									<div class="col-md-4 mb-4 mb-md-0">
										<label>Wohnberechtigungsschein</label>
										<div class="filled_input">$data.Wohnberechtigungsschein</div>
									</div>
									<div class="col-md-4 mb-4 mb-md-0">
										<label>Haustiere</label>
										<div class="filled_input">$data.Heizungsart</div>
									</div>
									<div class="col-md-4">
										<label>Netto Haushaltseinkommen</label>
										<div class="filled_input">$data.HouseholdIncome</div>
									</div>
								</div>
							</div>
							<div class="action action-min-width justify-content-center justify-content-md-end mt-md-5">
								<div class="default_btn"><a href="/stadtteile-berlins/view/$data.ApartmentID" class="btn-filled">Weiter zur wohnungsuche</a></div>
								<div class="default_outline_btn"><a href="$dashboardurl" class="btn-outline">Dein dashboard</a></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
        	<% include Footer %>

<% include MainFooter %>