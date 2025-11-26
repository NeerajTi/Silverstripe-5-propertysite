<% include MainHeader %>

<% include Header %>

<% include DashboardHeader %>
<style>
.image-preview{
    display: none;
}
.filesfilled
{
  color:white !important;
  background-color:#D98209 !important;
  border-color:#D98209 !important;
}
.nav-tabs .nav-link{
  margin-right:5px;
  background-color:#000;
  color:white;
}
</style>
<input type="hidden" name="SecurityID" value="$SecurityID">
<h1>$Title</h1>

<div class="progress_form">
  <div class="progress-container">
    <div class="progress_bar" style="width:76.9%;"></div>
  </div>

  <h2 class="mb-3">Beschreibungen:</h2>
  <form $Form.AttributesHTML>
    <input type="hidden" id="ObjectIDModal" value="$apartment.ID">
    $BilderID
    $DocumentID
    $VideoID
    $GrundID

    <div class="upload-section progress_form">
      <h2 class="mb-3">Fotos und Dokumenten zufügen:</h2>
 <div class="row align-items-start">
 <div class="col-12 col-sm-10">
<nav>
  <div class="nav nav-tabs" id="nav-tab" role="tablist">
    <button class="nav-link active <% if $apartment.Bilder.exists %>filesfilled<% end_if %>" id="nav-bilder-tab" data-bs-toggle="tab" data-bs-target="#nav-bilder" type="button" role="tab" aria-controls="nav-bilder" aria-selected="true">Bilder</button>
    <button class="nav-link <% if $apartment.Video %>filesfilled<% end_if %>" id="nav-video-tab" data-bs-toggle="tab" data-bs-target="#nav-video" type="button" role="tab" aria-controls="nav-video" aria-selected="false">Video</button>
    <button class="nav-link <% if $apartment.Document %>filesfilled<% end_if %>" id="nav-document-tab" data-bs-toggle="tab" data-bs-target="#nav-document" type="button" role="tab" aria-controls="nav-document" aria-selected="false">Document</button>
    <button class="nav-link <% if $apartment.Grund %>filesfilled<% end_if %>" id="nav-grund-tab" data-bs-toggle="tab" data-bs-target="#nav-grund" type="button" role="tab" aria-controls="nav-grund" aria-selected="false">Grund</button>
  </div>
</nav>
<div class="tab-content" id="nav-tabContent">
  <div class="tab-pane fade show active" id="nav-bilder" role="tabpanel" aria-labelledby="nav-bilder-tab">
    <div class="upload-card col align-items-center uploadtrigger" data-table='Apartment' data-action='/apartment/uploadFile' data-delete-action='/apartment/deleteFile' data-field='Bilder' data-target="BilderIDInput">
            <i class="fa-regular fa-image"></i>
            <div class="title">Bilder</div>
            <small>GIF, JPEG, PNG</small>
          </div>
            <div class="col">
              <div class="file-slot">
              <div class="upload-ui" data-for="BilderIDInput">
                <div class="progress" style="height:10px;">
                  <div class="progress-bar" role="progressbar" style="width:0%;">0%</div>
                </div>

                <% if $apartment.Bilder.exists %>
                  <div class="apartment-gallery gap-2 d-flex flex-wrap" data-deleteaction='/apartment/deleteFile' data-objectid="$apartment.ID">
                    <% loop $apartment.Bilder %>
                      <div class="apartment-image image-box">
                        <img src="$Fill(400,300).URL" class="upload-preview" alt="$Title.ATT">
                        <button class="delete-btn-multiple"
                                type="button"
                                data-field="Bilder"
                                data-fileid="$ID"
                                data-action="/apartment/deleteFile">
                          <i class="fa-solid fa-trash"></i>
                        </button>
                      </div>
                    <% end_loop %>
                  </div>
                <% else %>
                  <img src="" class="upload-preview" style="display:none" alt="">
                <% end_if %>
              </div>
            </div>
        </div>
         <div class='row mt-4'>
      <div class='js-gallery-multiple mb-2'></div>
      </div>
  </div>
  <div class="tab-pane fade" id="nav-video" role="tabpanel" aria-labelledby="nav-video-tab">
    <div class="upload-card col uploadtrigger" data-table='Apartment' data-action='/apartment/uploadFile' data-field='Video' data-target="VideoIDInput">
            <i class="fa-solid fa-video"></i>
            <div class="title">Video, Max 1 GB</div>
            <small>MPG, AVI, MOV, MKV, MP4</small>
          </div>
              <div class="col">
               <div class="file-slot">
              <div class="upload-ui" data-for="VideoIDInput">
                <div class="progress" style="height:10px;">
                  <div class="progress-bar" role="progressbar" style="width:0%;">0%</div>
                </div>

                <% if $apartment.Video %>
                  <div class="image-box image-preview" style="display:block">
                    <a href="$apartment.Video.URL" class="upload-preview" target="_blank">Video</a>
                    <button class="delete-btn" data-for="VideoIDInput" data-field="VideoID" data-objectid="$apartment.ID" data-table='Apartment' data-action='/apartment/deleteFile'><i class="fa-solid fa-trash"></i></button>
                  </div>
                <% else %>
                 <div class="image-box image-preview">
                  <a href="#;" class="upload-preview" style="display:none" target="_blank">Video</a>
                  </div>
                <% end_if %>
              </div>
            </div>
        </div>
  </div>
  <div class="tab-pane fade" id="nav-document" role="tabpanel" aria-labelledby="nav-document-tab">
     <div class="upload-card col uploadtrigger" data-table='Apartment' data-action='/apartment/uploadFile' data-field='Document' data-target="DocumentIDInput">
            <i class="fa-solid fa-file"></i>
            <div class="title">Dokumenten</div>
            <small>PDF</small>
          </div>
   <div class="col">
             <div class="file-slot">
              <div class="upload-ui" data-for="DocumentIDInput">
                <div class="progress" style="height:10px;">
                  <div class="progress-bar" role="progressbar" style="width:0%;">0%</div>
                </div>

                <% if $apartment.Document %>
                  <div class="image-box image-preview" style="display:block">
                    <a href="$apartment.Document.URL" class="upload-preview" target="_blank">Pdf</a>
                    <button class="delete-btn" data-for="DocumentIDInput" data-field="DocumentID" data-objectid="$apartment.ID" data-table='Apartment' data-action='/apartment/deleteFile'><i class="fa-solid fa-trash"></i></button>
                  </div>
                <% else %>
                  <div class="image-box image-preview">
                  <a href="#;" class="upload-preview" style="display:none" target="_blank">Pdf</a>
                  </div>
                <% end_if %>
              </div>
            </div>
        </div>
  </div>
   <div class="tab-pane fade" id="nav-grund" role="tabpanel" aria-labelledby="nav-grund-tab">
    <div class="upload-card col uploadtrigger" data-table='Apartment' data-action='/apartment/uploadFile' data-field='Grund' data-target="GrundIDInput">
            <i class="fa-solid fa-map"></i>
            <div class="title">Grundrisse</div>
            <small>GIF, JPEG, PNG, PDF</small>
          </div>
          <div class="col">
            <div class="file-slot">
              <div class="upload-ui" data-for="GrundIDInput">
                <div class="progress" style="height:10px;">
                  <div class="progress-bar" role="progressbar" style="width:0%;">0%</div>
                </div>

                <% if $apartment.Grund %>
                  <div class="image-box image-preview" style="display:block">
                    <% if $apartment.Grund.extension == 'pdf' %>
                      <a href="$apartment.Grund.URL" class="upload-preview" target="_blank">Grund</a>
                      <button class="delete-btn" data-for="GrundIDInput" data-field="GrundID" data-objectid="$apartment.ID" data-table='Apartment' data-action='/apartment/deleteFile'><i class="fa-solid fa-trash"></i></button>
                    <% else %>
                      <img src="$apartment.Grund.URL" class="upload-preview" alt="">
                      <button class="delete-btn" data-for="GrundIDInput" data-field="GrundID" data-objectid="$apartment.ID" data-table='Apartment' data-action='/apartment/deleteFile'><i class="fa-solid fa-trash"></i></button>
                    <% end_if %>
                  </div>
                <% else %>
                  <div class="image-box image-preview">
                  <img src="" style="display:none" class="upload-preview" alt="">
                  </div>
                <% end_if %>
              </div>
            </div>
        </div>
   </div>
</div>
</div>
  <div class="col-12 col-sm-2">
          <div class="tipp" style="max-width:260px;">
            <h3><i class="fa-regular fa-lightbulb"></i> Tipp:</h3>
            <div class="small_text">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut</div>
          </div>
        </div>
</div>
    
 
      <div class="row align-items-start">
      
    
       
        
      
      </div>
    
<div class='row'>
<div class="col"> <p class="mt-4 small_text">
            In die dokumenten dürfen keine personenbezogenen daten enthalten.<br>
            Namen, Adressen, Bankdaten von dritten enthalten.
          </p></div>
</div>
      <div class="default_btn text-right mt-5"> $Form.Actions</div>
    </div>
  </form>
</div>

<% include DashboardFooter %>

<% include Footer %>

<% include MainFooter %>
