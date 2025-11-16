<% include MainHeader %>

	<% include Header %>

		<%-- Persönliche Angaben --%>
		<div class="global_custom_form white_85 width_1088 pl-53 pr-53 pt-87 pt-27">
		  <h2 style="text-align:center;">Übermittlung Ihrer Daten</h2>
		  <form $Form.AttributesHTML>
		  <div class="row mb-3">
		    <div class="col-md-6">
		      $Firmaname
		    </div>
		    <div class="col-md-6">
		      $HRBHRA
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