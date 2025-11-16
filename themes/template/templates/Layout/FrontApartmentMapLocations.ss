<% include MainHeader %>

	<% include Header %>

    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"/>
    <style>
    #map { flex: 1; height: 100vh; }
    </style>
	<div class="project_list_view white_bg">
			<div class="container">
    <div class="sidebar" id="sidebar">
        <h3>Available Apartments</h3>

        <% if $ApartmentsWithCoords %>
            <% loop $ApartmentsWithCoords %>
                <input type="hidden" class="property"
                     data-title="$Address.Street"
                     data-lat="$Address.Lat"
                     data-lng="$Address.Lng"
                     data-url="/stadtteile-berlins/view/$ID">
               
            <% end_loop %>
        <% else %>
            <p>No published apartments found.</p>
        <% end_if %>
    </div>

    <div id="map"></div>
</div>
</div>
    <!-- Leaflet JS -->
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>

    <script>
        const map = L.map('map').setView([51.1657, 10.4515], 6); // Center on Germany (example)

        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 18,
            attribution: '&copy; OpenStreetMap contributors'
        }).addTo(map);

        const properties = document.querySelectorAll('.property');
        const markers = [];

        properties.forEach(el => {
            const lat = parseFloat(el.dataset.lat);
            const lng = parseFloat(el.dataset.lng);
            const title = el.dataset.title;
            const url = el.dataset.url;

            if (lat && lng) {
                const marker = L.marker([lat, lng]).addTo(map);
                marker.bindPopup(`<strong>${title}</strong><br><a href="${url}">View details →</a>`);

                // Hover sync
                el.addEventListener('mouseenter', () => {
                    marker.openPopup();
                    el.classList.add('active');
                });
                el.addEventListener('mouseleave', () => {
                    marker.closePopup();
                    el.classList.remove('active');
                });
                el.addEventListener('click', () => {
                    map.setView([lat, lng], 14);
                    marker.openPopup();
                });

                markers.push(marker);
            }
        });

        // Fit map to markers
        if (markers.length > 0) {
            alert(markers.length);
            const group = L.featureGroup(markers);
            map.fitBounds(group.getBounds().pad(0.2));
        }
    </script>

	<% include Footer %>

<% include MainFooter %>
