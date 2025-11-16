<% include MainHeader %>

	<% include Header %>

		<%-- Ubermittlung Ihrer Daten --%>
		<div class="global_custom_form white_85 width_1088 pl-53 pr-53 pt-87 pt-27">
		  <h2 style="text-align:center;">Übermittlung Ihrer Daten</h2>
		  <form $Form.AttributesHTML>
			  $InseriereAls

			  $Anrede

			  <div class="row mb-3">
			    <div class="col-md-6">
			      $FirstName
			    </div>
			    <div class="col-md-6">
			      $LastName
			    </div>
			  </div>

				<div class="side_bottom align_right pt-164">
				
					<div class="default_btn">
						$Form.Actions
					</div>
				</div>
			</form>
		</div>
		<%-- Persönliche Angaben ends--%>

	<% include Footer %>
	
<% include MainFooter %>