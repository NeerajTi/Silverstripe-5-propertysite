<%-- PropertyListMap.ss --%>
<div class="kamer asas">
<div class="row no-gutters">
							<div class="col-12">
<div class="map-list-wrap">
  

  <div class="map-and-items"">
    <div class="ajax-item-list" style="width:320px; overflow:auto; max-height:70vh;">
      <div id="ajaxMapData">
        <% loop $ApartmentsMap %>
          <% with $Address %>
            <% if $Lat && $Lng %>
            <% if $Up.Bilder.Exists %>
            <input type='hidden' class="prop" data-space="$Up.Details.Wohnflache" data-price="$Up.Details.Kaltmiete" data-image="$Up.Bilder.First.URL" data-lat="$Lat" data-lng="$Lng" data-title="$Street $Stadt" data-url="wohnungsuche/view/$Up.ID">
<% else %>
              <input type='hidden' class="prop" data-space="$Up.Details.Wohnflache" data-price="$Up.Details.Kaltmiete" data-image="/themes/template/images/image-placeholder.svg" data-lat="$Lat" data-lng="$Lng" data-title="$Street $Stadt" data-url="wohnungsuche/view/$Up.ID">
          <% end_if %>
            <% end_if %>
          <% end_with %>
        <% end_loop %>
      </div>
    </div>

    <div>
      <div id="ajaxMap" style="width:100%; height:70vh; min-height:350px;"></div>
    </div>
  </div>
</div>
</div>
  </div>
</div>
