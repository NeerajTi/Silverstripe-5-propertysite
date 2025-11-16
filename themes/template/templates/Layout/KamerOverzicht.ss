<div class="container">
	<article>
		<h1 class="global-title">$Title</h1>
		<!--<div class="content">$Content</div>-->
	</article>
	
</div>

<div class="container">
	<div class="row">
		<div class="col-lg-12 col-12">
			<div class="room-filter">$ProjectenResultsForm2</div>
			<!-- <div class="filterwaardes">$FilterSummary.RAW</div> -->
		</div>
		<div class="col-lg-12 col-12">
			<div class="adsensesidebar">
				<% include adsens %>
			</div>
		</div>	
	</div>
</div>

<div class="project_list_view">
	<div class="container">
		<div class="total_result_view">4.300 Mietwohnungen in Berlin</div>
		<div class="row">
			<div class="col-md-3">
				<div class="filter-widget">
					<!-- Map Section -->
					<div class="map-preview">
						<iframe style="height:100%;width:100%;border:0;" frameborder="0" src="https://www.google.com/maps/embed/v1/place?q=$City,+$$Address&key=AIzaSyCfb-eiIrgMep_e9DbwR0z8SFuDA4YulbM"></iframe>
						<a class="map-button">Auf die karte anzeigen</a>
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
							<div class="range-wrapper" data-min="0" data-max="2100" data-default="1050" data-prefix="€ " data-suffix="">
								<div class="custom-range-track" id="customTrack" >
									<div class="custom-range-fill" id="customFill"></div>
									<div class="custom-range-thumb" id="customThumb"></div>
								</div>
								<div class="range-labels">
									<span>€ 0</span>
									<span class="valueDisplay">€ 1050</span>
								</div>
							</div>
						</div>

						<!-- Space Filter -->
						<div class="filter-group">
							<label class="filter-label">Wohnungfläche</label>
							<div class="range-wrapper" data-min="0" data-max="200" data-default="200" data-prefix="" data-suffix=" m²">
								<div class="custom-range-track" id="customTrack">
									<div class="custom-range-fill" id="customFill"></div>
									<div class="custom-range-thumb" id="customThumb"></div>
								</div>
								<div class="range-labels">
									<span>0 m²</span>
									<span class="valueDisplay">200 m²</span>
								</div>
							</div>
						</div>

						<!-- Zimmer Filter -->
						<div class="filter-group">
							<label class="filter-label">Zimmer</label>
							<ul class="checkbox-list">
								<li><label><input type="checkbox" checked> Egal <span>620</span></label></li>
								<li><label><input type="checkbox"> 1 <span>435</span></label></li>
								<li><label><input type="checkbox"> 2 <span>203</span></label></li>
								<li><label><input type="checkbox"> 3 <span>189</span></label></li>
								<li><label><input type="checkbox"> 4 <span>6</span></label></li>
								<li><label><input type="checkbox"> 5 und mehr <span>2</span></label></li>
							</ul>
						</div>

						<div class="filter-group">
							<label class="filter-label">Stadtteil</label>
							<ul class="checkbox-list">
								<li><label><input type="checkbox" checked> Alle <span>620</span></label></li>
								<li><label><input type="checkbox"> Spandau <span>620</span></label></li>
								<li><label><input type="checkbox"> Neukölln <span>435</span></label></li>
								<li><label><input type="checkbox"> Zehlendorf <span>203</span></label></li>
								<li><label><input type="checkbox"> Charlottenburg <span>189</span></label></li>
								<li><label><input type="checkbox"> Berlin Mitte <span>6</span></label></li>
								<li><label><input type="checkbox"> Pankow <span>2</span></label></li>
								<li><label><input type="checkbox"> Prenzlauer Berg <span>189</span></label></li>
								<li><label><input type="checkbox"> Steglitz <span>6</span></label></li>
								<li><label><input type="checkbox"> Lichtenrade <span>2</span></label></li>
								<li><label><input type="checkbox"> Tegel <span>2</span></label></li>
								<li><label><input type="checkbox"> Kreuzberg <span>2</span></label></li>
								<li><label><input type="checkbox"> Blankenburg <span>2</span></label></li>
								<li><label><input type="checkbox"> Kladow <span>2</span></label></li>
								<li><label><input type="checkbox"> Frohnau <span>2</span></label></li>
							</ul>
						</div>

							<div class="filter-group">
								<label class="filter-label">Was suchen sie?</label>
								<ul class="checkbox-list">
									<li><label><input type="checkbox"> Wohnung <span>620</span></label></li>
									<li><label><input type="checkbox"> WG Zimmer <span>435</span></label></li>
									<li><label><input type="checkbox"> Haus <span>203</span></label></li>
									<li><label><input type="checkbox"> Wohnung auf Zeit <span>189</span></label></li>
									<li><label><input type="checkbox"> Garage oder Stellplatz <span>6</span></label></li>
								</ul>
							</div>

							<div class="filter-group">
								<label class="filter-label">Wohnberechtigungsschein (WBS)</label>
								<ul class="checkbox-list">
									<li><label><input type="checkbox"> Alle angebote <span>620</span></label></li>
									<li><label><input type="checkbox"> WBS erforderlich <span>435</span></label></li>
									<li><label><input type="checkbox"> WBS nicht erforderlich <span>203</span></label></li>
								</ul>
							</div>

							<div class="filter-group">
								<label class="filter-label">Haustiere</label>
								<ul class="checkbox-list">
									<li><label><input type="checkbox"> Nach Zustimmung <span>620</span></label></li>
									<li><label><input type="checkbox"> Nicht erlaubt <span>435</span></label></li>
									<li><label><input type="checkbox"> Erlaubt <span>203</span></label></li>
								</ul>
							</div>

							<div class="filter-group">
								<label class="filter-label">Ausstattung</label>
								<ul class="checkbox-list">
									<li><label><input type="checkbox"> Garage / Stellplatz <span>620</span></label></li>
									<li><label><input type="checkbox"> Einbauküche <span>435</span></label></li>
									<li><label><input type="checkbox"> Keller <span>203</span></label></li>
									<li><label><input type="checkbox"> Gäste - WC <span>189</span></label></li>
									<li><label><input type="checkbox"> Personenaufzug <span>6</span></label></li>
									<li><label><input type="checkbox"> Stufenloser Zugang <span>2</span></label></li>
								</ul>
							</div>

						<!-- Extra Filters -->
						<div class="filter-group extra-filters">
							<label class="filter-label">Extra filters <span class="toggle-icon"><i class="fas fa-chevron-down"></i></span></label>
						</div>

						<!-- Save Button -->
						<div class="save-button-wrap">
							<a class="save-search-button"><i class="fa fa-search"></i> Suche speichern</a>
						</div>
					</div>
				</div>

			</div>
			<div class="col-md-9">
				<% include KamerAanbod %>
			</div>
		</div>
	</div>
</div>

<script>
  document.querySelectorAll('.range-wrapper').forEach(wrapper => {
    const track = wrapper.querySelector('.custom-range-track');
    const thumb = wrapper.querySelector('.custom-range-thumb');
    const fill = wrapper.querySelector('.custom-range-fill');
    const display = wrapper.querySelector('.valueDisplay');

    const min = parseInt(wrapper.dataset.min);
    const max = parseInt(wrapper.dataset.max);
    const prefix = wrapper.dataset.prefix || '';
    const suffix = wrapper.dataset.suffix || '';
    let value = parseInt(wrapper.dataset.default);

    function updateUI(val) {
      const percent = (val - min) / (max - min);
      const trackWidth = track.offsetWidth;
      const pos = percent * trackWidth;
      thumb.style.left = `${pos}px`;
      fill.style.width = `${pos}px`;
      display.textContent = `${prefix}${val}${suffix}`;
    }

    function getValueFromPosition(x) {
      const rect = track.getBoundingClientRect();
      let pos = x - rect.left;
      pos = Math.max(0, Math.min(pos, rect.width));
      const percent = pos / rect.width;
      return Math.round(min + percent * (max - min));
    }

    function handleMove(e) {
      value = getValueFromPosition(e.clientX);
      updateUI(value);
    }

    track.addEventListener('click', handleMove);

    thumb.addEventListener('mousedown', () => {
      const onMouseMove = e => handleMove(e);
      const onMouseUp = () => {
        document.removeEventListener('mousemove', onMouseMove);
        document.removeEventListener('mouseup', onMouseUp);
      };
      document.addEventListener('mousemove', onMouseMove);
      document.addEventListener('mouseup', onMouseUp);
    });

    updateUI(value);
  });
</script>