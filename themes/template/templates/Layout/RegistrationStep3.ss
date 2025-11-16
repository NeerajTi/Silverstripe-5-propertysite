<% include MainHeader %>

	<% include Header %>

		<%-- Ubermittlung Ihrer Daten --%>
		<div class="global_custom_form white_85 width_1088 pl-53 pr-53 pt-87 pt-27 fw-radio fs-18">
		  <h2 class="text-center mb-0">Übermittlung Ihrer Daten</h2>
		  <form $Form.AttributesHTML>
			  $Type

				<div class="side_bottom align_right pt-115">
					
					<div class="default_btn">
						$Form.Actions
					</div>
				</div>
			</form>
		</div>
		<%-- Persönliche Angaben ends--%>

	<% include Footer %>
	
<% include MainFooter %>