
<% loop Projecten %>

<% if $Pos = 1 %> 
<div class="row">
  <div class="col-md-12">
   <% include adsens %>
  </div>
</div>

<% end_if %>
    <div class="kamer asas">
      <div class="row no-gutters">

        <div class="col-md-5 col-xs-12">
          <div class="image">
            <a href="<% if $Top.SiteConfig.KamerLink %><% loop Top %>$SiteConfig.KamerLink<% end_loop %>$Link<% else %><% loop Top.Kameroverzichtpagina %>$URLSegment<% end_loop %>$Link<% end_if %>">    
              <img src="$AffiliateImage" alt="$Address">
            </a>
            <div class="overlay">
              <a href="<% if $Top.SiteConfig.KamerLink %><% loop Top %>$SiteConfig.KamerLink<% end_loop %>$Link<% else %><% loop Top.Kameroverzichtpagina %>$URLSegment<% end_loop %>$Link<% end_if %>" class="bekijkkamer hidden-sm hidden-xs">
                Diese Wohnung ansehen
              </a>
            </div>
          </div>
        </div>

        <div class="col-md-7 col-xs-12">
          <div class="project_info">
            <div class="project_name_price">
              <h3>
                <a href="<% if $Top.SiteConfig.KamerLink %><% loop Top %>$SiteConfig.KamerLink<% end_loop %>$Link<% else %><% loop Top.Kameroverzichtpagina %>$URLSegment<% end_loop %>$Link<% end_if %>">
                  $Address</a> <span class="small">$Top.SiteConfig.Stad</span> <span class="code">0123456789</span>
              </h3>
              <div class="aanbod-prijs">
                <i class="fa-regular fa-heart wishlist show-on-mobile"></i>
                € $Price
                <span class="small">Kaltmiete</span>
              </div>
            </div>

            <div class="map_view">
              <a href="#">
                <i class="fa-solid fa-location-dot"></i> Auf der Karte anzeigen
              </a>
            </div>
            <div class="project_extra_info">
              <div class="info-wrap">
                <div class="beschikbaarvan icon_text">
                  <i class="fa-regular fa-calendar"></i>
                  <div class="label">Bezugsfrei ab</div>
                  <div class="value">$availableFromdate.Format('dd-MM-y')</div>
                </div>
                <div class="surface icon_text">
                  <i class="fa-solid fa-house"></i>
                  <div class="label">Wohnfläche</div>
                  <div class="value">$EchteOppervlakte &#13217;</div>
                </div>
                <div class="number_of_bed icon_text">
                  <i class="fa-solid fa-bed"></i>
                  <div class="label">Schlafzimmer</div>
                  <div class="value">2</div>
                </div>
              </div>
              <div class="view_appartment">
                <i class="fa-regular fa-heart wishlist hide-on-mobile"></i>
                <a class="btn" href="<% if $Top.SiteConfig.KamerLink %><% loop Top %>$SiteConfig.KamerLink<% end_loop %>$Link<% else %><% loop Top.Kameroverzichtpagina %>$URLSegment<% end_loop %>$Link<% end_if %>">Wohnung ansehen</a>
              </div>
            </div>

          </div>
        </div>

      </div>
    </div>


<% if $Pos = 7 %> 
<div class="row">
  <div class="col-md-12">
   <% include adsens %>

  </div>
</div>

<% end_if %>



<% end_loop %>



<div class="pagination">
  <% if $Projecten.MoreThanOnePage %>
    <% if $Projecten.NotFirstPage %>
        <a class="prev" href="$Projecten.PrevLink">Vorherige</a>
    <% end_if %>
    <% loop $Projecten.PaginationSummary(4) %>
          <% if $Link %>
              <li <% if $CurrentBool %>class="active"<% end_if %>><a href="$Link">$PageNum</a></li>
          <% else %>
              <li><a href="#" class="ThreeDots" role="button" disabled>...</a> </li>
          <% end_if %>
    <% end_loop %>
    <% if $Projecten.NotLastPage %>
        <a class="next" href="$Projecten.NextLink">Nächste</a>
    <% end_if %>
  <% end_if %>
</div>
