<div class="container">
  <h1>$Title</h1>

  <% if $Query %>
  <h2 class="aanbod-heading">Zoekresultaten: &quot;<strong>{$Query}&quot;</strong></h2>
  <% end_if %>

  <div class="col-md-8">
    <% if Results %>
    <ul class="searchResults">
      <% loop Results %>
      <li>
        <a class="searchResultHeader">
          <img src="$NieuwsImage.CroppedImage(300, 200).URL" class="img-thumbnail"/>
          $MenuTitle
        </a>
      </li>
      <% end_loop %>
    <% else  %>
      <li><p>Wij hebben geen resultaten kunnen vinden.</p></li>
    </ul>
    <% end_if %>
  </div>
</div>