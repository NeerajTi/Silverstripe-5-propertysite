<% include MainHeader %>

<% include Header %>

<% include DashboardHeader %>

<h1>$Title</h1>
<style>
.action
{
  padding-top:0px!important;
  padding-bottom:0px!important;
}
</style>
<div class="progress_form filled_form contact_details_app">

  <div class="row">
    <div class="col-12 col-xl-5">
      <div class="filled_input d-flex justify-content-between"><span>Referenznummer : </span><span>$Apartment.ObjectNumber</span></div>
      <div class="filled_input d-flex justify-content-between mt-2"><span>Projekt : </span><span>$Apartment.GroupNumber</span></div>
      <div class="filled_input d-flex justify-content-between mt-2 wohnung_type"><span>Wohnung Type : </span><span>$Apartment.WohnungType</span></div>
      <div class="default_btn text-right">
     <a href="/apartment/step1/?apartmentID=$Apartment.ID&preview=1" class="action">Edit</a>
     </div>
    </div>
  </div>

  <!-- Adresse Section -->
  <div class="section section-adresse address">
    <div class="row">
      <div class="col-12">
        <h3>Adresse:</h3>
      </div>
      <div class="col-12 col-xl-5 mt-2">
        <div class="filled_input d-flex justify-content-between"><span>Strasse : </span><span>$Apartment.Address.Street</span></div>
      </div>
      <div class="col-12 col-xl-5 mt-2 offset-xl-1">
        <div class="filled_input d-flex justify-content-between"><span>Nr : </span><span>$Apartment.Address.Nr</span></div>
      </div>
      <div class="col-12 col-xl-5 mt-2">
        <div class="filled_input d-flex justify-content-between"><span>PLZ : </span><span>$Apartment.Address.Plz</span></div>
      </div>
    
      <div class="col-12 col-xl-5 mt-2">
        <div class="filled_input d-flex justify-content-between"><span>Strasse und Hausnummer anzeigen : </span><span>$Apartment.Address.StrasseundHausnummer</span></div>
      </div>
      <div class="col-12 col-xl-5 offset-xl-1 mt-2">
        <!-- blank or placeholder col if needed -->
      </div>
      <div class="col-12 col-xl-5 mt-2">
        <div class="filled_input d-flex justify-content-between"><span>Stadt : </span><span>$Apartment.Address.Stadt</span></div>
      </div>
      <div class="col-12 col-xl-5 offset-xl-1 mt-2">
        <div class="filled_input d-flex justify-content-between"><span>Stadtteil : </span><span>$Apartment.Address.Stadtteil</span></div>
      </div>
    </div>
    <div class="default_btn text-right">
     <a href="/apartment/step2/?apartmentID=$Apartment.ID&preview=1" class="action">Edit</a>
     </div>
  </div>
  <!-- End Adresse Section -->

  <!-- Echdaten Section -->
  <div class="section section-echdaten">
    <div class="row">
      <div class="col-12">
        <h3>Echdaten:</h3>
      </div>
      <div class="col-12 col-xl-5 mt-2"><div class="filled_input d-flex justify-content-between"><span>Wohnfläche : </span><span>$Apartment.Details.Wohnflache m²</span></div></div>
      <div class="col-12 col-xl-5 mt-2 offset-xl-1"><div class="filled_input d-flex justify-content-between"><span>Zimmer : </span><span>$Apartment.Details.Zimmer</span></div></div>
      <div class="col-12 col-xl-5 mt-2"><div class="filled_input d-flex justify-content-between"><span>Kaltmiete : </span><span>$Apartment.Details.Kaltmiete Euro</span></div></div>
      <div class="col-12 col-xl-5 offset-xl-1 mt-2"><div class="filled_input d-flex justify-content-between"><span>FloorVerfugbarAb : </span><span>$Apartment.Details.FloorVerfugbarAb</span></div></div>
      <div class="col-12 col-xl-5 mt-2"><div class="filled_input d-flex justify-content-between"><span>Nebenkosten : </span><span>$Apartment.Details.Nebenkosten Euro</span></div></div>
      <div class="col-12 col-xl-5 offset-xl-1 mt-2"><div class="filled_input d-flex justify-content-between"><span>Kaution : </span><span>$Apartment.Details.Kaution</span></div></div>
      
	  <div class="col-12">
        <h4>Heizunkosten in Nebenkosen:</h4>
      </div>
      <div class="col-12 col-xl-5"><div class="filled_input d-flex justify-content-between"><span>Gesamtmiete : </span><span>$Apartment.Details.Gesamtmiete Euro</span></div></div>
    </div>
     <div class="default_btn text-right">
     <a href="/apartment/step3/?apartmentID=$Apartment.ID&preview=1" class="action">Edit</a>
     </div>
  </div>
  <!-- End Echdaten Section -->

  <!-- Details Section -->
  <div class="section section-details">
    <div class="row">
      <div class="col-12">
        <h3>Details:</h3>
      </div>
      <div class="col-xl-5">
        <div class="row">
        <% if $DetailOptions %>
          <% loop $DetailOptions %>
            <div class="col-12 col-xl-6 mt-2">
              <div class="filled_input d-flex justify-content-between">
                <span>$Key</span>
              </div>
            </div>
          <% end_loop %>
        <% end_if %>
        <div class="col-12"></div>
        <div class="col-12 mt-2">
          <div class="filled_input d-flex justify-content-between">
            <span><strong>Qualitat der Wohnung:</strong></span>
            <span>$Apartment.Details.QualitatDerWohnung</span>
          </div>
        </div>
        </div>
      </div>
       <div class="default_btn text-right">
     <a href="/apartment/step4/?apartmentID=$Apartment.ID&preview=1" class="action">Edit</a>
     </div>
    </div>

    <div class="row">
      <div class="col-12">
        <h4>Anzahl voorzieningen:</h4>
      </div>
      <div class="col-12 col-xl-5"><div class="filled_input d-flex justify-content-between"><span>Schlafzimmer: </span><span>$Apartment.Details.Schlafzimmer</span></div></div>
      <div class="col-12 col-xl-5 offset-xl-1"><div class="filled_input d-flex justify-content-between"><span>Badezimmer: </span><span>$Apartment.Details.Badezimmer</span></div></div>
      <div class="col-12 col-xl-5 mt-2"><div class="filled_input d-flex justify-content-between"><span>Etage: </span><span>$Apartment.Details.Etage Von $Apartment.Details.Von</span></div></div>
      <div class="col-12 col-xl-5 offset-xl-1 mt-2"><div class="filled_input d-flex justify-content-between"><span>Nutzflache: </span><span>$Apartment.Details.Nutzflache m²</span></div></div>
      <div class="col-12 col-xl-5 mt-2"><div class="filled_input d-flex justify-content-between"><span><strong>Wohnberechtigungsscein:</strong> </span><span>$Apartment.Details.Wohnberechtigungsschein</span></div></div>
      <div class="col-12 col-xl-5 offset-xl-1 mt-2"><div class="filled_input d-flex justify-content-between"><span><strong>Heizungart:</strong> </span><span>$Apartment.Details.Heizungsart</span></div></div>
      <div class="col-12 col-xl-5 mt-2"><div class="filled_input d-flex justify-content-between"><span><strong>Internetgeschwindigkeit:</strong> </span><span>$Apartment.Internetgeschwindigkeit</span></div>  <div class="default_btn text-right">
     <a href="/apartment/step6/?apartmentID=$Apartment.ID&preview=1" class="action">Edit</a>
     </div></div>
      <div class="col-12 col-xl-5 offset-xl-1 mt-2"><div class="filled_input d-flex justify-content-between"><span><strong>Energieeffiziezklasse:</strong> </span><span>$Apartment.Energieeffiziezklasse</span></div>  <div class="default_btn text-right">
     <a href="/apartment/step6/?apartmentID=$Apartment.ID&preview=1" class="action">Edit</a>
     </div></div>
    </div>
     <div class="default_btn text-right">
     <a href="/apartment/step5/?apartmentID=$Apartment.ID&preview=1" class="action">Edit</a>
     </div>
  </div>
  <!-- End Anzahl voorzieningen Section -->

  <!-- Beschreibungen Section -->
  <div class="section section-beschreibungen">
    <div class="row">
      <div class="col-12">
        <h3>Beschreibungen:</h3>
      </div>
      <div class="col-12">
        <h4>Uberschrift*:</h4>
        <div class="filled_input">$Apartment.Uberschrift</div>
         <div class="default_btn text-right">
     <a href="/apartment/step7/?apartmentID=$Apartment.ID&preview=1" class="action">Edit</a>
     </div>
      </div>
      <div class="col-12">
        <h4>Mietwohnung*:</h4>
        <div class="filled_input">$Apartment.Mietwohnung</div>
         <div class="default_btn text-right">
     <a href="/apartment/step8/?apartmentID=$Apartment.ID&preview=1" class="action">Edit</a>
     </div>
      </div>
      <div class="col-12">
        <h4>Dieumgebung*:</h4>
        <div class="filled_input">$Apartment.Dieumgebung</span></div>
         <div class="default_btn text-right">
     <a href="/apartment/step9/?apartmentID=$Apartment.ID&preview=1" class="action">Edit</a>
     </div>
      </div>
    </div>
  </div>
  <!-- End Beschreibungen Section -->

  <!-- Fotos und Dokumenten Section -->
  <div class="section section-fotos">
    <div class="row">
      <div class="col-sm-12">
        <h3>Fotos und Dokumenten zufügen:</h3>
      </div>
      <div class="col-sm-12">
        <div class="uploaded_files">
		<% if $Apartment.Bilder %>
          <% loop $Apartment.Bilder %>
            <img src="$URL" alt="$Title" style='width:70px;height:auto'>
          <% end_loop %>
        <% end_if %>
        <% if $Apartment.Video %>
          <a href="$Apartment.Video.URL" class="upload-preview" target="_blank">Video</a>
        <% end_if %>
        <% if $Apartment.Document %>
          <a href="$Apartment.Document.URL" class="upload-preview" target="_blank">Pdf</a>
        <% end_if %>
        <% if $Apartment.Grund %>
          <% if $Apartment.Grund.extension == 'pdf' %>
            <a href="$Apartment.Grund.URL" class="upload-preview" target="_blank">Grund</a>
          <% else %>
            <img src="$Apartment.Grund.URL" class="upload-preview" alt="">
          <% end_if %>
        <% end_if %>
		</div>
      </div>
    </div>
      <div class="default_btn text-right">
     <a href="/apartment/step10/?apartmentID=$Apartment.ID&preview=1" class="action">Edit</a>
     </div>
  </div>
  <!-- End Fotos und Dokumenten Section -->

  <!-- Bausubstanz und Energieausweis Section -->
  <div class="section section-energie">
    <div class="row">
      <div class="col-12">
        <h3>Bausubstanz und Energieausweis:</h3>
      </div>
      <div class="col-12 col-xl-5"><div class="filled_input d-flex justify-content-between"><span>Objektzustand:</span><span>$Apartment.Objektzustand</span></div></div>
      <div class="col-12 col-xl-5 offset-xl-1"><div class="filled_input d-flex justify-content-between"><span>Heizungart:</span><span>$Apartment.Heizungart</span></div></div>
      <div class="col-12 col-xl-5 mt-2"><div class="filled_input d-flex justify-content-between"><span>Letzte Modernisierung:</span><span>$Apartment.LetzteModernisierung</span></div></div>
      <div class="col-12 col-xl-5 offset-xl-1 mt-2"><div class="filled_input d-flex justify-content-between"><span>Wesentlichter Energietrager:</span><span>$Apartment.WesentlichterEnergietrager</span></div></div>
      <div class="col-12 col-xl-5 mt-2"><div class="filled_input d-flex justify-content-between"><span>Baujahr des Gebäudes:</span><span>$Apartment.BaujahrDesGebaudes</span></div></div>
      <div class="col-12">
       <div class="default_btn text-right">
     <a href="/apartment/step11/?apartmentID=$Apartment.ID" style='padding-top:0px;padding-bottom:0px;' class="action">Edit</a>
     </div>
      </div>
      <div class="col-12 col-xl-7 mt-2"><div class="filled_input d-flex justify-content-between"><span>Energieausweis liegt zur Besigtigung vor:</span><span>$Apartment.Energieausweis</span></div></div>
      <div class="col-12 col-xl-7 mt-2"><div class="filled_input d-flex justify-content-between"><span>Dieses Gebaude unterliegt den Anforderungen de GEG:</span><span>$Apartment.Dieses</span></div></div>
      <div class="col-12 col-xl-7 mt-2"><div class="filled_input d-flex justify-content-between"><span>Energieausweis liegt vor:</span><span>$Apartment.EnergieausweisVor</span></div></div>
     <div class="default_btn text-right">
     <a href="/apartment/step12/?apartmentID=$Apartment.ID" style='padding-top:0px;padding-bottom:0px;' class="action">Edit</a>
     </div>
    </div>
  </div>
  <!-- End Bausubstanz und Energieausweis Section -->
	<div class="section section-contact">
   <% if $userType=='broker' %>
	<div class="row">
		<div class="col-12">
			<h3>Kontaktdaten:</h3>
		</div>
   
		<div class="col-12 col-xl-5">
		<div class="landlord_head">
			<div class="header-left d-flex align-items-center gap-3">
      <% if $Contact.Image %>
        <img src="$Contact.Image.URL" alt="User Thumb">
      <% else %>
        <img src="/themes/template/images/user_thumb.png" alt="User Thumb">
      <% end_if %>
			<div class="content">
				<h4>$Contact.FirstName $Contact.LastName</h4>
				<div class="email"><i class="fa-solid fa-envelope"></i> E-mail: $Contact.Email</div>
				<div class="phone"><i class="fa-solid fa-phone"></i> Tel: $Contact.Telefon</div>
			</div>
			</div>
       <div class="default_btn text-right">
     <a href="/apartment/step13/?apartmentID=$Apartment.ID&preview=1" class="action">Edit</a>
     </div>
		</div>
		</div>
   
	</div>
  </div>
 <% end_if %>
  <div class="default_btn text-right">
  <% if $IsSubscriptionActive=='Active' %>
    <a href="/apartment/listingcreated/?apartmentID=$Apartment.ID" style='padding-top:0px;padding-bottom:0px;' class="action">Weiter</a>
  <% else %>
    <a href="/apartment/subscription/" class="action">Weiter</a>
  <% end_if %>
  </div>

</div>

<% include DashboardFooter %>

<% include Footer %>

<% include MainFooter %>
