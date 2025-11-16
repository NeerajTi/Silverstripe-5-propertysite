

<% loop Projecten %>

<% if $Pos = 1 %> 
<div class="row">
  <div class="col-md-12">
   <% include adsens %>
  </div>
</div>

<% end_if %>
<div class="row">
  <div class="col-md-12">
    <div class="kamer">
      <div class="row no-gutters">
        <div class="col-md-3 col-xs-12">
          
           <a href="<% if $Top.SiteConfig.KamerLink %>  <% loop Top %>$SiteConfig.KamerLink<% end_loop %>$Link <% else %> <% loop Top.Kameroverzichtpagina %>$URLSegment<% end_loop %>$Link<% end_if %>">    
            
            <div class="img-holder" style="background:URL('$AffiliateImage'); background-size:cover; background-position: center;">
            </div>
          </a>
        </div>

        <div class="col-md-6 col-xs-12">
          <b class="kamer-straat">
   
               $Address - $Top.SiteConfig.FilterWoord</a></b>
               <a href="<% if $Top.SiteConfig.KamerLink %>  <% loop Top %>$SiteConfig.KamerLink<% end_loop %>$Link <% else %> <% loop Top.Kameroverzichtpagina %>$URLSegment<% end_loop %>$Link<% end_if %>" class="bekijkkamer hidden-sm hidden-xs">Dieser Wohnung ansehen</a>
          <div class="info">
            <span class="type" style="width:100%">
             <% if $kindLabel == 'entire place' && $typeLabel == 'apartment' %>
                 Gesamte Wohnung
                 <% else %>
                     <% if $kindLabel == 'shared room' %> Mehrbettzimmer ($bedroomSize 	&#13217;) im <% end_if %>
                     <% if $kindLabel == 'private room' %> WG-Zimmer ($bedroomSize 	&#13217;) im <% end_if %>
                     <% if $kindLabel == 'entire place' %>  Gesamte  <% end_if %>

                     <% if $typeLabel == 'apartment' %> Apartment<% end_if %>
                     <% if $typeLabel == 'house' %> Wohnung <% end_if %>
                     <% if $typeLabel == 'building' %> Wohnung <% end_if %>
             <% end_if %>

            </span>
            <span class="oppervlakte" style="width:100%; float: left;">Wohnungseigentum $EchteOppervlakte &#13217; </span>
            <span class="beschikbaarvan" style="width:100%; float: left;">Verfügbar $availableFromdate.Format('dd-MM-y')</span>
            <span class="aanbod-prijs" style="width:100%; float: left;">$Price</span>
          </div>
     
          <style>
       
       .beschikbaarvan::before {
    content: "";
    font-family: fontawesome;
    margin-right: 15px;
    display: inline-block;
    font-weight: bold;

    color: rgb(85, 85, 85);
    width: 40px !important;
    height: 40px !important;
    background: rgb(245, 245, 245);
    padding: 9px;
}        </style>
        
          <p class="beschrijving" style="display:none">$Description.LimitCharacters(100)</p>
        </div>
  
        <div class="col-md-3 hidden-sm hidden-xs">
          <div style=""><div id="mymap-canvas" style="height:200px; width:100%;max-width:100%;"><iframe style="height:100%;width:100%;border:0;" frameborder="0" src="https://www.google.com/maps/embed/v1/place?q=$City,+$$Address&key=AIzaSyCfb-eiIrgMep_e9DbwR0z8SFuDA4YulbM"></iframe></div><style>#mymap-canvas img.text-marker{max-width:none!important;background:none!important;}img{max-width:none}</style></div>		
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
