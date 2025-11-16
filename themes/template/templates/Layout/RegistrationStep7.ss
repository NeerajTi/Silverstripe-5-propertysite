<% include MainHeader %>

	<% include Header %>
<input type="hidden" name="SecurityID" value="$SecurityID">
		<%-- Ubermittlung Ihrer Daten --%>
		<div class="global_custom_form white_100 width_1360">
		  <h2>Miet arbeiter Angaben <span class="btn btn-secondary" data-bs-container="body" data-bs-toggle="popover" data-bs-placement="bottom" data-bs-content="Information">Info</span></h2>
		  <form $Form.AttributesHTML>
		  <input type="hidden" name="AjaxFileUploadId" id='AjaxFileUploadId' value="0">
			  	<div class="row mb-3">
					<div class="col-12">
	  <div class="upload-ui" data-for="FotoIDInput">
  <div class="progress" style="height:10px;">
    <div class="progress-bar" role="progressbar" style="width:0%;">0%</div>
  </div>
 
<img src="" alt="User Placeholder" class="upload-preview" style="max-width:180px; display:none; margin-top:10px;display:none">


</div>
						<!-- Upload label -->
						<label class="upload-box uploadtrigger" data-target="FotoIDInput" data-action='/registration/uploadFile' data-field="Image" data-table='RentalWorkerInformation' for="fileUpload">
							<div class="upload-left">
							<img src="https://img.icons8.com/ios-filled/50/image--v1.png" alt="icon">
							<span class="file-name" id="file-name" style="display: block;">Foto</span>
							</div>
							<span class="file-types">JPEG, PNG</span>
						</label>

						<!-- Hidden file input -->
						$Foto

					</div>

				
				</div>

				<div class="row mb-3">
					<div class="col-12 textarea">
						$Description
						<span class="words_count"></span>
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