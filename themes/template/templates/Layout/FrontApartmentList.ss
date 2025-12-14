<% include MainHeader %>

	<% include Header %>
  
      <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/leaflet@1.9.4/dist/leaflet.css">
      
	<style>
.managed-list .city-part-item:nth-child(n+11),
.managed-list .equipment-item:nth-child(n+11) {
    display: none;
}


	.ajax-overlay[hidden] { display: none !important; }

.ajax-overlay {
  position: fixed;
  inset: 0;                   /* top/right/bottom/left: 0 */
  background: rgba(0,0,0,.35);
  z-index: 2000;              /* above headers/modals — adjust if needed */
  display: flex;
  align-items: center;
  justify-content: center;
  pointer-events: all;        /* block clicks */
  cursor: wait;
}

.ajax-overlay__inner {
  display: flex;
  gap: .75rem;
  align-items: center;
  background: rgba(255,255,255,.95);
  padding: 1rem 1.25rem;
  border-radius: .5rem;
  box-shadow: 0 10px 30px rgba(0,0,0,.2);
}

.ajax-overlay__text {
  font-weight: 600;
}

/* Optional: prevent scroll while overlay visible */
html.is-busy, body.is-busy { overflow: hidden; }
</style>
<style>
/* force hide */
.filter-section .filter-group.hidden {
    display: none !important;
}

/* keep .extra-filters visible (if accidentally hidden in some cases) */


/* pointer for clickable row */
.filter-group.extra-filters { cursor: pointer; user-select: none; }


</style>

	<div id="globalAjaxOverlay" class="ajax-overlay" aria-live="polite" aria-busy="false" hidden>
  <div class="ajax-overlay__inner">
    <!-- Bootstrap 4/5 spinner -->
    <div class="spinner-border" role="status" aria-label="Bitte warten…"></div>
    <div class="ajax-overlay__text">Bitte warten…</div>
  </div>
</div>
	<input type="hidden" id="SecurityID" value="$SecurityID">
  <input type="hidden" id="viewtype" value="list">
<div class="container">
	<article>
		<!--<div class="content"><p>Willkommen auf der Website wohnungmietenberlin.de. Die Website, auf der Sie schnell eine passende Unterkunft in Berlin finden werden. Gehen Sie am besten zum Filter und wählen Sie dann die Höhe der Höchstmiete. Wenn Sie ein passendes Objekt gefunden haben, klicken Sie es an und dann auf "Weitere Informationen". Dort finden Sie alle Informationen darüber, wie Sie die Immobilie mieten können und wie Sie den Vermieter kontaktieren können.</p></div>-->
	</article>
	
</div>
		<div class="project_list_view white_bg">
			<div class="container">
      <div class="title-header">
        <h1 class="global-title">$Title</h1>
      </div>
      <div class="total_result_view hide-on-mobile">$totalApartments Mietwohnungen in Berlin</div>
		<div class="row">
		<div class="col-xl-3 col-sm-12 col-md-4">
		<div class="filter-widget">
    <div class="map-preview" id="viewbuttonlist" style='display:none'>
					 <a class="map-button" href='javascript:void(0);' onclick="setviewtype('list','map')">Auf die Liste anzeigen</a>
					</div>

		<!-- Map Section -->
					<div class="map-preview" id='viewbuttonmap'>
						<iframe style="height:100%;width:100%;border:0;" frameborder="0" src="https://www.google.com/maps/embed/v1/place?q=,+$&amp;key=AIzaSyCfb-eiIrgMep_e9DbwR0z8SFuDA4YulbM"></iframe>
						<a class="map-button" href='javascript:void(0);' onclick="setviewtype('map','list')">Auf die karte anzeigen</a>
					</div>
		</div>
		<!-- Filter Panel -->
					<div class="filter-section">
						<h2>Filtern</h2>

						<!-- Price Filter -->
						<div class="filter-group">
							<div class="select_row">
								<label class="filter-label">Preis</label>
								<select class="filter-select">
									<option>Kaltmiete</option>
									<option>Warmmiete</option>
								</select>
							</div>
						<div class="range-wrapper"
     data-name="price"
     data-min="$MinPrice"
     data-max="$MaxPrice"
     data-min-default="$MinPrice"
     data-max-default="$MaxPrice"
     data-prefix="€ "
     data-suffix="">
     
  <div class="custom-range-track">
    <div class="custom-range-fill"></div>
    <div class="custom-range-thumb thumb-min"></div>
    <div class="custom-range-thumb thumb-max"></div>
  </div>

  <div class="range-labels">
    <span class="minDisplay">€ $MinPrice</span>
    <span class="maxDisplay">€ $MaxPrice</span>
  </div>
</div>

						
						</div>

						<!-- Space Filter -->
						<div class="filter-group">
							<label class="filter-label">Wohnungfläche</label>
						<div class="range-wrapper"
     data-name="space"
     data-min="$MinRoomspace"
     data-max="$MaxRoomspace"
     data-min-default="$MinRoomspace"
     data-max-default="$MaxRoomspace"
     data-prefix=""
     data-suffix=" m²">

  <div class="custom-range-track">
    <div class="custom-range-fill"></div>
    <div class="custom-range-thumb thumb-min"></div>
    <div class="custom-range-thumb thumb-max"></div>
  </div>

  <div class="range-labels">
    <span class="minDisplay">$MinRoomspace m²</span>
    <span class="maxDisplay">$MaxRoomspace m²</span>
  </div>
</div>

						</div>

						<!-- Zimmer Filter -->
						<div class="filter-group filter-group-hidden hidden" >
							<label class="filter-label">Zimmer</label>
							<ul class="checkbox-list">
							<li><label><input type="checkbox" data-name="Rooms" data-role="any" value="" class="checkboxfilter" checked=""> Egal <span>$TotalRooms</span></label></li>
							<% if $RoomCounts %>
								<%loop $RoomCounts %>
								<li><label><input type="checkbox" data-name="Rooms" value="$Key" checked class="checkboxfilter"> 
                <% if $Key==5 %>
                5 und mehr 
                <% else %>
                $Key
                <% end_if %>
                
                <span>$Value</span></label></li>
								<% end_loop %>
								<% end_if %>
							</ul>
						</div>

						<div class="filter-group filter-group-hidden hidden">
							<label class="filter-label">Stadtteil</label>
							<ul class="checkbox-list managed-list city-part-list" data-target="city-part-list">
								<li class="city-part-item all-option"><label><input type="checkbox" data-name='Location' data-role="any" value="" class="checkboxfilter" checked=""> Alle <span>$TotalCityParts</span></label></li>
								<% if $CityPartCounts %>
								<%loop $CityPartCounts %>
								<li class="city-part-item"><label><input type="checkbox" data-name='Location' <% if $Up.state==$Key %>checked="checked"<% end_if %> value="$Key" checked class="checkboxfilter"> $Key <span>$Value</span></label></li>
								<% end_loop %>
								<% end_if %>
								
							</ul>
               <button class="view-more-btn btn" data-target="city-part-list" >View More</button>
               <button class="view-less-btn btn" data-target="city-part-list" style="display: none;">View Less</button>
						</div>

				

							<div class="filter-group filter-group-hidden hidden">
								<label class="filter-label">Ausstattung</label>
								<ul class="checkbox-list managed-list equipment-list" data-target="equipment-list">
                	<li class="equipment-item all-option"><label><input type="checkbox" data-name='equipment' data-role="any" value="" class="checkboxfilter" checked=""> Alle</label></li>
								<% if $OptionCounts %>
									<%loop $OptionCounts %>
									<li class="equipment-item"><label><input data-name='equipment' value="$Key" class="checkboxfilter" type="checkbox" checked> $Key <span>$Value</span></label></li>
									<% end_loop %>
									<% end_if %>

								</ul>
                 <button class="view-more-btn btn" data-target="equipment-list" >View More</button>
               <button class="view-less-btn btn" data-target="equipment-list" style="display: none;">View Less</button>
							</div>

						<!-- Extra Filters -->
						<div class="filter-group extra-filters">
							<label class="filter-label">Alle Filter <span class="toggle-icon"><i class="fas fa-chevron-down"></i></span></label>
						</div>

						<!-- Save Button -->
						<div class="save-button-wrap">
         
            <% if $isLoggedIn && $userType == 'renter' %>
            
							<a class="save-search-button user-save-search" ><i class="fa fa-search"></i> Suche speichern</a>
            <% else %>
            <a class="save-search-button" data-bs-toggle="popover" data-bs-placement="bottom"  data-bs-html="true" data-bs-content="Please <a href='/login'>login</a> as renter to save search" ><i class="fa fa-search"></i> Suche speichern</a>
            <% end_if %>
						</div>
					</div>
		</div>
		<div class="col-xl-9 col-sm-12 col-md-8">
	<div id="PropertyListTarget"><% include PropertyList %></div>
   <div id="loadMoreTrigger" style="height: 1px;"></div>
    <div id="noMoreAptMessage" style='display:none' class="alert alert-primary" role="alert">
    Keine weiteren Wohnungen
    </div>
		</div>
 
		</div>


			</div>
		</div>
<script>
const endpoint =`/$CurrentUrl/ajaxview`;
  const securityID = document.querySelector('input[name=SecurityID]')?.value || '';
  const target = document.getElementById('PropertyListTarget');
function setviewtype(view,showv)
{
  document.getElementById('viewtype').value=view;
  document.getElementById('viewbuttonlist').style.display='none';
  document.getElementById('viewbuttonmap').style.display='none';

document.getElementById('viewbutton'+showv).style.display='block';
 // Disable lazy load observer for map view, enable for list view
  if (view === 'map') {
    observer.unobserve(observerTarget);
    const noMoreMsg = document.getElementById('noMoreAptMessage');
    if (noMoreMsg) noMoreMsg.style.display = 'none';
  } else {
    resetLazyLoad(); // Reset and enable for list view
  }
  fetchList();
}
function showAjaxOverlay() {
  const ov = document.getElementById('globalAjaxOverlay');
  if (!ov) return;
  ov.hidden = false;
  ov.setAttribute('aria-busy', 'true');
  document.documentElement.classList.add('is-busy');
  document.body.classList.add('is-busy');
}

function hideAjaxOverlay() {
  const ov = document.getElementById('globalAjaxOverlay');
  if (!ov) return;
  ov.hidden = true;
  ov.setAttribute('aria-busy', 'false');
  document.documentElement.classList.remove('is-busy');
  document.body.classList.remove('is-busy');
}

/* If multiple AJAX calls can overlap, use a ref counter */
let __ajaxCounter = 0;
function ajaxOverlayOn() { if (++__ajaxCounter === 1) showAjaxOverlay(); }
function ajaxOverlayOff() { if (__ajaxCounter > 0 && --__ajaxCounter === 0) hideAjaxOverlay(); }
// small debounce helper

const debounce = (fn, wait = 250) => {
  let t;
  return (...args) => {
    clearTimeout(t);
    t = setTimeout(() => fn(...args), wait);
  };
};

  
 

  // Collect current values from all sliders
function collectFilters() {
  const data = {};

  document.querySelectorAll('.range-wrapper').forEach(w => {
    const name = w.dataset.name || w.id || 'slider';

    const minVal = parseInt(w.dataset.minValue);
    const maxVal = parseInt(w.dataset.maxValue);

    // Send both values
    if (!isNaN(minVal)) {
      data[`${name}_min`] = minVal;
    }

    if (!isNaN(maxVal)) {
      data[`${name}_max`] = maxVal;
    }
  });

  return data;
}



  async function fetchList() {
    if (!target) return;
    var view=document.getElementById('viewtype').value;
    const payload = buildPayload();
    payload.append('view', view);
   for (const [key, value] of payload.entries()) {
  console.log(`${key}: ${value}`);
}

    try {
      const res = await fetch(endpoint, {
        method: 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' },
        body: payload
      });
      const html = await res.json();
      target.innerHTML = html.html;
      if (view === 'map') initMapInPanel();
    } catch (e) {
      console.error('AJAX load failed', e);
    } finally {
    ajaxOverlayOff();
  }
  }

  const fetchListDebounced = debounce(() => {
  resetLazyLoad(); // Reset lazy load state when filters change
  fetchList();
}, 250);
document.querySelectorAll('.range-wrapper').forEach(wrapper => {
  const track = wrapper.querySelector('.custom-range-track');
  const fill = wrapper.querySelector('.custom-range-fill');
  const thumbMin = wrapper.querySelector('.thumb-min');
  const thumbMax = wrapper.querySelector('.thumb-max');
  const minDisplay = wrapper.querySelector('.minDisplay');
  const maxDisplay = wrapper.querySelector('.maxDisplay');

  const min = parseInt(wrapper.dataset.min);
  const max = parseInt(wrapper.dataset.max);
  const prefix = wrapper.dataset.prefix || '';
  const suffix = wrapper.dataset.suffix || '';

  let minVal = parseInt(wrapper.dataset.minDefault);
  let maxVal = parseInt(wrapper.dataset.maxDefault);

  function valueToPos(val) {
    return ((val - min) / (max - min)) * track.offsetWidth;
  }

  function posToValue(x) {
    const rect = track.getBoundingClientRect();
    let pos = Math.max(0, Math.min(x - rect.left, rect.width));
    return Math.round(min + (pos / rect.width) * (max - min));
  }

  function updateUI() {
    const minPos = valueToPos(minVal);
    const maxPos = valueToPos(maxVal);

    thumbMin.style.left = `${minPos}px`;
    thumbMax.style.left = `${maxPos}px`;

    fill.style.left = `${minPos}px`;
    fill.style.width = `${maxPos - minPos}px`;

    minDisplay.textContent = `${prefix}${minVal}${suffix}`;
    maxDisplay.textContent = `${prefix}${maxVal}${suffix}`;
     // 👇 IMPORTANT for AJAX
  wrapper.dataset.minValue = minVal;
  wrapper.dataset.maxValue = maxVal;
  }

  function startDrag(type) {
    const move = e => {
      const val = posToValue(e.clientX);

      if (type === 'min') {
        minVal = Math.min(val, maxVal - 1);
      } else {
        maxVal = Math.max(val, minVal + 1);
      }

      updateUI();
      fetchListDebounced();
    };

    const stop = () => {
      document.removeEventListener('mousemove', move);
      document.removeEventListener('mouseup', stop);
    };

    document.addEventListener('mousemove', move);
    document.addEventListener('mouseup', stop);
  }

  thumbMin.addEventListener('mousedown', () => startDrag('min'));
  thumbMax.addEventListener('mousedown', () => startDrag('max'));

  updateUI();
});


  // --- Checkbox group behavior (Any vs specific) + trigger AJAX ---
document.addEventListener('change', (e) => {
  const cb = e.target.closest('.checkboxfilter');
  if (!cb) return;

  const group = cb.dataset.name;
  const boxes = Array.from(document.querySelectorAll(`.checkboxfilter[data-name="${group}"]`));
  const anyBox = boxes.find(b => b.dataset.role === 'any');

  if (cb.dataset.role === 'any') {
    // If "Egal" is toggled on, uncheck all specifics
    if (cb.checked) {
      boxes.forEach(b => { if (b !== cb) b.checked = true; });
    } else {
      // keep at least one checked; if user unchecks "any" and none others checked, re-check it
      if (!boxes.some(b => b !== cb && b.checked)) cb.checked = true;
    }
  } else {
   
    // If a specific is checked, uncheck "Egal"
    if (anyBox) anyBox.checked = false;

    // If all specifics are off, ensure "Egal" goes back on
    const anySpecificOn = boxes.some(b => b.dataset.role !== 'any' && b.checked);
    if (!anySpecificOn && anyBox) anyBox.checked = true;
  }

  // Debounced reload
  fetchListDebounced();
});
function buildPayload() {
  const fd = new FormData();

  // Sliders (persisted as dataset.value by your slider code)
  const filters = collectFilters(); // { price: "...", space: "..." }
  Object.entries(filters).forEach(([k, v]) => fd.append(k, v));
  fd.append('SecurityID', securityID);

  // Checkbox groups (collect checked non-empty values, send as name[]=v)
  const groups = {};
  document.querySelectorAll('.checkboxfilter').forEach(cb => {
    const name = cb.dataset.name || 'misc';
    if (!groups[name]) groups[name] = [];
    if (cb.checked && cb.value !== '') groups[name].push(cb.value);
  });

  Object.entries(groups).forEach(([name, values]) => {
    if (values.length) {
      values.forEach(v => fd.append(`${name}[]`, v)); // e.g. Rooms[]=2&Rooms[]=3
    }
    // If none selected (or only "any" selected), omit => means "no restriction"
  });

  return fd;
}
</script>
<script>
document.addEventListener('DOMContentLoaded', function () {
    // find the extra-filters toggle element
    const toggle = document.querySelector('.filter-group.extra-filters');
    if (!toggle) return;

    // find all filter-group elements within the section
    const section = toggle.closest('.filter-section');
    if (!section) return;

    const allGroups = Array.from(section.querySelectorAll('.filter-group-hidden'));
    // make a list of groups to hide/show (all except the toggle itself)
    const groupsToToggle = allGroups.filter(g => !g.classList.contains('extra-filters'));

    const icon = toggle.querySelector('.toggle-icon i');

    // function to set state
    function setCollapsed(collapsed) {
        groupsToToggle.forEach(g => {
            if (collapsed) g.classList.add('hidden');
            else g.classList.remove('hidden');
        });

        // icon toggle
        if (icon) {
            icon.classList.toggle('fa-chevron-down', !collapsed);
            icon.classList.toggle('fa-chevron-up', collapsed);
        }

        // ARIA for accessibility
        toggle.setAttribute('aria-pressed', collapsed ? 'true' : 'false');

        // optional class on section
        section.classList.toggle('collapsed', collapsed);
    }

    // initialize state (not collapsed)
    let collapsed = true;
    setCollapsed(collapsed);

    // click handler
    toggle.addEventListener('click', function (e) {
        collapsed = !collapsed;
        setCollapsed(collapsed);
    });

    // keyboard support (Enter / Space to toggle)
    toggle.addEventListener('keydown', function (e) {
        if (e.key === 'Enter' || e.key === ' ') {
            e.preventDefault();
            collapsed = !collapsed;
            setCollapsed(collapsed);
        }
    });
});
function initMapInPanel() {
  // Wait a tick so DOM is fully rendered
  setTimeout(() => {
    // ensure Leaflet resources loaded (you should already include Leaflet <link> and <script> globally)
    // Build markers from elements inside the loaded panel
    const mapEl = document.querySelector('#ajaxMap');
    if (!mapEl) return;

    // read center and markers from data attributes
    const items = Array.from(document.querySelectorAll('#ajaxMapData .prop'));
    const markers = [];

    // initialize map only once
    // if map already exists, remove / reset it
    if (window.ajaxMapInstance) {
      try { window.ajaxMapInstance.remove(); } catch (err) { /* ignore */ }
      window.ajaxMapInstance = null;
    }

    // default center or first marker
    const defaultLatLng = items.length ? [parseFloat(items[0].dataset.lat), parseFloat(items[0].dataset.lng)] : [52.5200, 13.4050];

    const map = L.map('ajaxMap', { preferCanvas: true }).setView(defaultLatLng, 12);
    window.ajaxMapInstance = map;

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      maxZoom: 19,
      attribution: '&copy; OpenStreetMap contributors'
    }).addTo(map);

    items.forEach(el => {
      const lat = parseFloat(el.dataset.lat);
      const lng = parseFloat(el.dataset.lng);
      const title = el.dataset.title || '';
      const image = el.dataset.image || '';
      const space = el.dataset.space || '';
      const price = el.dataset.price || '';
      const url = el.dataset.url || '#';
      if (!isFinite(lat) || !isFinite(lng)) return;
      const m = L.marker([lat, lng]).addTo(map);
      var datamap=`<div class="location_pop"><div class="pop_img"><img src="${image}" alt="${title}"></div>
      <div class="pop_text">
        <a href="${url}">${title}</a>
        <div class="pop_space">${space} m²</div>
      <div class="aanbod-prijs">
											€ ${price}
										</div></div>
      </div>`;
      m.bindPopup(datamap,{maxWidth: 300,   // width in px
  Height: 300,closeButton: false,
  autoClose: false,
  closeOnClick: false  });
      markers.push(m);

      // highlight list item on marker hover

m.on('mouseover', () => {
  m.openPopup();
  el.classList.add('active');
});


m.on('mouseout', () => {
  m.closePopup();
  el.classList.remove('active');
});

      // clicking list item pans to marker
      el.addEventListener('click', (ev) => {
        map.setView([lat, lng], 14, { animate: true });
        m.openPopup();
      });
    });

    if (markers.length) {
      const group = L.featureGroup(markers);
      map.fitBounds(group.getBounds().pad(0.15));
    }

    // If map initially hidden/inside collapsed container, ensure tiles recalc:
    setTimeout(() => map.invalidateSize(), 250);

  }, 50);
}

// small helper to escape HTML in JS (same as earlier)
function escapeHtml(s){
  if(!s) return '';
  return String(s).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;')
                   .replace(/"/g,'&quot;').replace(/'/g,'&#039;');
}
</script>
<script>
let currentPage = 1;
let loadingMore = false;
let hasMore = true; // Will be false when no more results

const observerTarget = document.getElementById('loadMoreTrigger');


const observer = new IntersectionObserver(entries => {
  const view = document.getElementById('viewtype').value;
  // Only load more if we're in list view
  if (view === 'list' && entries[0].isIntersecting && !loadingMore && hasMore) {
    loadMoreApartments();
  }
}, {
  rootMargin: '200px',
});
// Only observe if initial view is list
document.addEventListener('DOMContentLoaded', function() {
  const initialView = document.getElementById('viewtype').value;
  if (initialView === 'list') {
    observer.observe(observerTarget);
  }
});
observer.observe(observerTarget);

async function loadMoreApartments() {
  loadingMore = true;
  ajaxOverlayOn();

  const view = document.getElementById('viewtype').value;
  const payload = buildPayload();
  payload.append('view', view);
  payload.append('page', currentPage + 1); // next page

  try {
    const res = await fetch(endpoint, {
      method: 'POST',
      headers: { 'X-Requested-With': 'XMLHttpRequest' },
      body: payload
    });

    const data = await res.json();

    if (!data.html || !data.hasMore) {
      hasMore = false;
      observer.unobserve(observerTarget);
      const noMoreMsg = document.getElementById('noMoreAptMessage');
  if (noMoreMsg) noMoreMsg.style.display = 'block';
      return;
    }

    // Append new HTML nodes inside container
    const tempDiv = document.createElement('div');
    tempDiv.innerHTML = data.html;
    Array.from(tempDiv.children).forEach(item => target.appendChild(item));

    currentPage++;
    hasMore = data.hasMore;
    if (!hasMore) observer.unobserve(observerTarget);
  } catch (e) {
    console.error('Error loading more apartments:', e);
  } finally {
    ajaxOverlayOff();
    loadingMore = false;
  }
}
function resetLazyLoad() {
  currentPage = 1;
  hasMore = true;
  loadingMore = false;
  
  const noMoreMsg = document.getElementById('noMoreAptMessage');
  if (noMoreMsg) noMoreMsg.style.display = 'none';
  
  // Re-observe the trigger if it was unobserved
  observer.observe(observerTarget);
}

document.addEventListener("DOMContentLoaded", function() {
    const maxVisible = 10;  // Number of items to show initially

    // Function to handle "View More" and "View Less" toggling for any managed list
    function setupViewMoreLess(buttonsContainer, targetClass) {
        const items = buttonsContainer.querySelectorAll(`.${targetClass} .city-part-item, .${targetClass} .equipment-item`);
        const viewMoreBtn = buttonsContainer.querySelector(`.view-more-btn[data-target="${targetClass}"]`);
        const viewLessBtn = buttonsContainer.querySelector(`.view-less-btn[data-target="${targetClass}"]`);

        // Show View More button only if there are more items than the maxVisible
        if (items.length > maxVisible) {
            viewMoreBtn.style.display = "block";
        } else {
            viewMoreBtn.style.display = "none"; // Hide View More if less than 10 items
        }

        // Handle "View More" button click
        viewMoreBtn.addEventListener("click", function() {
            items.forEach(function(item, index) {
                if (index >= maxVisible) {
                    item.style.display = "block"; // Show items after the 10th one
                }
            });
            viewMoreBtn.style.display = "none";  // Hide View More button
            viewLessBtn.style.display = "block";  // Show View Less button
        });

        // Handle "View Less" button click
        viewLessBtn.addEventListener("click", function() {
            items.forEach(function(item, index) {
                if (index >= maxVisible) {
                    item.style.display = "none";  // Hide items after the 10th one
                }
            });
            viewLessBtn.style.display = "none";  // Hide View Less button
            viewMoreBtn.style.display = "block";  // Show View More button
        });
    }

    // Apply to all managed lists
    const managedLists = document.querySelectorAll(".filter-group .managed-list");
    managedLists.forEach(function(list) {
        const targetClass = list.getAttribute("data-target");
        const buttonsContainer = list.closest(".filter-group");  // Get the filter group container
        setupViewMoreLess(buttonsContainer, targetClass);
    });
});



</script>

   <script src="https://cdn.jsdelivr.net/npm/leaflet@1.9.4/dist/leaflet.js"></script>
  
	<% include Footer %>

<% include MainFooter %>