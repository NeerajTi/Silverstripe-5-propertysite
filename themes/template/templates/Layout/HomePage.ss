

<section class="banner-home front_banner" style="background:url('<% if $Afbeelding %>$Afbeelding.LazyLoad(true).URL<% else %>/stock-image.webp<% end_if %>'); background-size:cover; background-position:center;">
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-12 my-auto">
				<h1 class="global-title hide-on-mobile"><img src="/themes/template/images/search-logo.png" alt="Wohnung mieten Berlin"> $PageTitle</h1>
				<%-- <div class="room-filter">$ProjectenResultsForm2</div> --%>
				<div class="button-row">
					<a href="/wohnungsuche/" class="btn btn-primary">Wohnung mieten</a>
					<a href="/login/" class="btn btn-secondary">Kostenlos vermieten</a>
				</div>
			</div>
		</div>
	</div>
</section>
<section class="welcome_content">
	<div class="container">
		<article>
			<h2 class="page-title-home">$Title</h2>
			<div class="content">$Content</div>
		</article>
	</div>
</section>

<section class="main-content">
	<div class="container">
		<h2>Kürzlich hinzugefügte wohnungen</h2>
		<div class="recently_projects owl-carousel">
	<% include PropertyListGrid %>
		</div>
	</div>
</section>

<section class="how_does_it_works">
	<div class="container">
		<h2>Wie functioniert ess?</h2>
		<div id="horizontalTab">
			<div class="tab_wrap">
				<ul class="resp-tabs-list">
					<li><a href="javascript:void(0)">Mieter</a></li>
					<li><a href="javascript:void(0)">Vermieter</a></li>
				</ul>
			</div>

			<div class="resp-tabs-container">
				<div class="wrap">
					<div class="content" id="tab-1">
						<div class="icon_blocks_wrapper">
							<div class="icon_blocks">
								<div class="icon"><i class="fa-solid fa-house"></i></div>
								<div class="title">Suche dein wohnung</div>
								<div class="short_text">
									Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec adipiscing tristique risus nec feugiat in fermentum posuere urna.
								</div>
							</div>

							<div class="icon_blocks active">
								<div class="icon"><i class="fa-solid fa-message"></i></div>
								<div class="title">Contact aufnehmen</div>
								<div class="short_text">
									Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec adipiscing tristique risus nec feugiat in fermentum posuere urna.
								</div>
							</div>

							<div class="icon_blocks">
								<div class="icon"><i class="fa-solid fa-calendar-check"></i></div>
								<div class="title">Termin vereinbaren</div>
								<div class="short_text">
									Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec adipiscing tristique risus nec feugiat in fermentum posuere urna.
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="wrap">
					<div class="content" id="tab-2">
						<div class="icon_blocks_wrapper">
							<div class="icon_blocks">
								<div class="icon"><i class="fa-solid fa-house"></i></div>
								<div class="title">Suche dein wohnung</div>
								<div class="short_text">
									Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec adipiscing tristique risus nec feugiat in fermentum posuere urna.
								</div>
							</div>

							<div class="icon_blocks active">
								<div class="icon"><i class="fa-solid fa-message"></i></div>
								<div class="title">Contact aufnehmen</div>
								<div class="short_text">
									Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec adipiscing tristique risus nec feugiat in fermentum posuere urna.
								</div>
							</div>

							<div class="icon_blocks">
								<div class="icon"><i class="fa-solid fa-calendar-check"></i></div>
								<div class="title">Termin vereinbaren</div>
								<div class="short_text">
									Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec adipiscing tristique risus nec feugiat in fermentum posuere urna.
								</div>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<section class="full_width_content">
	<div class="container">
		<h2>Kostenlos Wohnung anbieten</h2>
		<div class="editor_text">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque lorem quam, commodo id diam nec, tincidunt convallis felis. Vivamus eu vehicula massa. Vestibulum pellentesque, mi vel ultricies pretium, velit diam ullamcorper lectus, sed vehicula leo lacus at orci. Etiam iaculis ligula eget ex placerat sollicitudin. Sed rutrum vulputate ante, rhoncus mollis elit. Phasellus turpis orci, commodo commodo sapien quis, rutrum consequat diam. In vitae enim ac tellus cursus cursus. In ultricies euismod tellus posuere ornare. Curabitur viverra sem et sem fermentum convallis sollicitudin vel nisi. Quisque fringilla luctus purus, non faucibus magna ultricies ut. Ut nec convallis massa, eget malesuada sapien.</div>
		<div class="default_btn"><a href="#">Snel Bewerben</a></div>
	</div>
</section>

<section class="overlay_bg_content">
	<div class="container">
		<h2>Die größte Auswahl an Wohnungen in Berlin</h2>
		<div class="editor_text">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque lorem quam, commodo id diam nec, tincidunt convallis felis. Vivamus eu vehicula massa. Vestibulum pellentesque, mi vel ultricies pretium, velit diam ullamcorper lectus, sed vehicula leo lacus at orci. Etiam iaculis ligula eget ex placerat sollicitudin. Sed rutrum vulputate ante, rhoncus mollis elit. Phasellus turpis orci, commodo commodo sapien quis, rutrum consequat diam. In vitae enim ac tellus cursus cursus. In ultricies euismod tellus posuere ornare. Curabitur viverra sem et sem fermentum convallis sollicitudin vel nisi. Quisque fringilla luctus purus, non faucibus magna ultricies ut. Ut nec convallis massa, eget malesuada sapien.</div>
		<div class="default_outline_btn"><a href="#">Starte Ihre Wohnung suche</a></div>
	</div>
</section>

<section class="news-section">
	<div class="container">
		<h2>Berlin Aktuell</h2>
		<div class="news-carousel owl-carousel news-items">
			<% loop $LaatsteNieuws %>
				<div class="news-card">
					<div class="news-image">
						<img src="https://housinganywhere.imgix.net/room/1148304/8ffc5d55-9535-11e6-bdd5-42010af00008.jpg" alt="$Title">
					</div>
					<% if $FeaturedImage.URL %>
					<div class="news-image">
						<img src="$FeaturedImage.URL" alt="$Title">
					</div>
					<% end_if %>
					<div class="news_info">
						<h3 class="news-title"><a href="$Link">$Title</a></h3>
						<div class="news-summary">$Content.LimitCharacters(100)</div>
						<a href="$Link" class="read-more-button">Mehr Lesen</a>
					</div>	
				</div>
			<% end_loop %>
		</div>
	</div>
</section>

<% include Questions %>



<%--
<div class="row">
	<div class="col-md-12">
		<% include KamerAanbod %>
	</div>
	<% if $SecondContent %>
	<div class="col-md-12 col-xs-12" style="margin-top:50px; margin-bottom:50px;">
		$SecondContent
	</div>
	<% end_if %>
	<% if $AllQuestions %>
	<div class="col-lg-12 col-12">
		<h2 class="mb-3">Häufig gestellte Fragen</h2>
		<div class="accordion" id="accordionExample" itemscope itemtype="https://schema.org/FAQPage">
			<% loop $AllQuestions %>
				<% if $Subsite == $Top.Subsite.ID %>
					<div class="accordion-item" itemprop="mainEntity" itemscope itemtype="https://schema.org/Question">
						<h2 class="accordion-header" id="heading$ID">
							<button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#question$ID" aria-expanded="true" aria-controls="question$ID" itemprop="name">
								<span itemprop="text">$Title</span>
							</button>
						</h2>
						<div id="question$ID" class="accordion-collapse collapse <% if $Pos = "1" %>show<% end_if %>" aria-labelledby="heading$ID" data-bs-parent="#accordion$ID" itemprop="acceptedAnswer" itemscope itemtype="https://schema.org/Answer">
							<div class="accordion-body" itemprop="text">
								$Antwoord
							</div>
						</div>
					</div>
				<% end_if %>
			<% end_loop %>
		</div>	
	</div>	
	<% end_if %>
	--%>
