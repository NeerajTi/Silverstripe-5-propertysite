<% include MainHeader %>

	<% include Header %>

		<%-- Personaliche Angaben --%>
		<div class="global_custom_form white_100 width_1360">
			<h2>Personaliche Angaben</h2>
			<form $Form.AttributesHTML>
				<div class="row">
					<div class="col-md-12">
						$Anrede
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
					<div class="col-md-12 col-sm-12">
						$Geburtsdatum
					</div>
				</div>

				<div class="row mb-3">
					<div class="col-md-10 col-sm-10">
						$Strabe
					</div>
					<div class="col-md-2 col-sm-2">
						$Nr
					</div>
				</div>

				<div class="row mb-3">
					<div class="col-md-2 col-sm-2">
						$Plz
					</div>
					<div class="col-md-5 col-sm-5">
						$Ort
					</div>
					<div class="col-md-5 col-sm-5">
						$Land
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

				<div class="row mb-4">
					<div class="col-md-6">
						$Email
					</div>
					<div class="col-md-6">
						$Fax
					</div>
				</div>

				<div class="side_bottom align_right">
					<div class="default_btn">
						$Form.Actions
					</div>
				</div>
			</form>
		</div>
		<%-- Persönliche Angaben ends--%>

	<% include Footer %>
	
<% include MainFooter %>