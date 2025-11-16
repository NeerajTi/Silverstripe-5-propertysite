<% include MainHeader %>

	<% include Header %>

		<%-- Firma --%>
		<div class="global_custom_form white_100 width_1360">
			<h2>Miet arbeiter Angaben</h2>
			<form $Form.AttributesHTML>
				<div class="row mb-3">
					<div class="col-md-6 custom_radio">
					    $Anrede
					</div>
					<div class="col-md-6">
						$Titel
					</div>
				</div>
				<div class="row mb-3">
					<div class="col-md-6">
						$Vorname
					</div>
					<div class="col-md-6">
						$Nachname
					</div>
				</div>

				<div class="row mb-3">
					<div class="col-6 col-md-4 col-sm-4">
						$CountryCode
					</div>
					<div class="col-6 col-md-8 col-sm-8">
						$Telefon
					</div>
				</div>

				<div class="row mb-3">
					<div class="col-12">
						$Email
					</div>
				</div>

				<div class="row mb-3">
					<div class="col-12">
						$ZusaEmail
					</div>
				</div>

				<div class="row mb-3">
					<div class="col-12">
						$PositionUnterneehmen
					</div>
				</div>

				<div class="row mb-4">
					<div class="col-6">
						$Mobile
					</div>
					<div class="col-6">
						$Fax
					</div>
				</div>

				<div class="row last_row">
					<div class="col-md-6">
						$StandaardContact
					</div>
					<div class="col-md-6 align_right">
						<div class="side_bottom align_right">
							<div class="default_btn">
								$Form.Actions
							</div>
						</div>	
					</div>
				</div>
				$WorkerID
			</form>
		</div>
		<%-- Persönliche Angaben ends--%>

	<% include Footer %>
	
<% include MainFooter %>