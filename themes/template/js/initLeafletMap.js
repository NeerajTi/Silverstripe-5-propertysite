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
        const url = el.dataset.url || '#';
        if (!isFinite(lat) || !isFinite(lng)) return;
        const m = L.marker([lat, lng]).addTo(map);
        m.bindPopup(`<strong>${escapeHtml(title)}</strong><br/><a href="${url}">Details</a>`);
        markers.push(m);
  
        // highlight list item on marker hover
      m.on('mouseover', () => {
    el.classList.add('active');
  });
  m.on('mouseout', () => {
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