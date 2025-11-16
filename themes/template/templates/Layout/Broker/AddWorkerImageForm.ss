<% include MainHeader %>

	<% include Header %>

		<%-- Ubermittlung Ihrer Daten --%>
		<div class="global_custom_form white_100 width_1360">
		  <h2>Miet arbeiter Angaben</h2>
		  <form $Form.AttributesHTML>
			  	<div class="row mb-3">
					<div class="col-12">

						<!-- Upload label -->
						<label class="upload-box" for="fileUpload">
							<div class="upload-left">
							<img src="https://img.icons8.com/ios-filled/50/image--v1.png" alt="icon">
							<span class="file-name" id="file-name" style="display: block;">Foto</span>
							</div>
							<span class="file-types">JPEG, PNG</span>
						</label>

						<!-- Hidden file input -->
						$Foto

					</div>

					<script>
					const fileInput = document.getElementById('fileUpload');
					const fileName = document.getElementById('file-name');

					fileInput.addEventListener('change', function () {
						if (this.files.length > 0) {
							fileName.textContent = this.files[0].name;
						} else {
							fileName.textContent = 'Foto';
						}
					});
					</script>
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