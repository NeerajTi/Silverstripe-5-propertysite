<div class="top-bar">
  <div class="container-fluid">
  	<div class="row">
		<div class="top-bar-content">
			<div class="col-md-2 col-sm-4 col-xs-5">
				<div class="logo">
					<a href="/" ><img src="$SiteConfig.Logo.URL" class="img-responsive" alt="logo"/></a>
				</div>
			</div>  

			<div class="col-md-10 col-sm-8 col-xs-7 ">        
				<div class="menu hidden-sm hidden-xs">
				<% loop Menu(1) %>
				<% if $Children %>
					<div class="children">
					<p href="$Link" class="button">$MenuTitle <i class="fa fa-caret-down"></i></a>
					<div class="dropdown">
						<% loop $Children %>
						<a href="$Link" class="button">$MenuTitle</a>
						<% end_loop %>
					</div>				
				</div>	
<% else %>
				<a href="$Link" class="button">$MenuTitle</a>
	
			
		<% end_if %>

				<% end_loop %>

				<div class="children">
					<p href="$Link" class="button">Andere Städte <i class="fa fa-caret-down"></i></p>
					<div class="dropdown">
					<% loop $SubsiteList %>
						<% if $Top.Subsite.ID != $ID %>
						<a href="https://$Domain" class="button">$Title</a>
						<% end_if %>
					<% end_loop %>						
					</div>				
				</div>
				<div class="children">
					<p href="$Link" class="button">Andere Länder <i class="fa fa-caret-down"></i></p>
					<div class="dropdown">
						<div class="spain"><a href="https://www.pisoenalquilermadrid.es/" class="button">Spanien</a></div>
						<div class="spain"><a href="https://www.kameramsterdam.com/" class="button">Die Niederlande</a></div>
						<div class="spain"><a href="https://www.wohnungmietenbasel.ch/" class="button">Schweiz</a></div>
						<div class="spain"><a href="https://www.appartamentoaffittoroma.it/" class="button">Italien</a></div>

					</div>				
				</div>					
			</div>
			<!-- GOOGLE TRANSLATE -->
			<!-- <script type="text/javascript">
				function googleTranslateElementInit() {
					new google.translate.TranslateElement({pageLanguage: 'de', includedLanguages: 'de,en,nl,es', layout: google.translate.TranslateElement.InlineLayout.SIMPLE}, 'google_translate_element');
				}
			</script><script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script> -->
			  <div class="dropdown country-dropdown">
				<button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown"><img src="$themedResourceURL('images/germanflag.jpg')" /> <span class="caret"></span></button>
				<ul class="dropdown-menu translation-icons">
				<li><a href="#" class="es" data-placement="3"><img src="$themedResourceURL('images/spainflag.png')" alt="Spanische Flagge"/></a></li>
				<li><a href="#" class="eng" data-placement="1"><img src="$themedResourceURL('images/dutchflag.jpg')" alt="Niederländische Flagge"/></a></li>
				<li><a href="#" class="eng" data-placement="2"><img src="$themedResourceURL('images/englishflag.jpg')" alt="Englische Flagge"/></a></li>
				<li><a href="#" class="ger" data-placement="0"><img src="$themedResourceURL('images/germanflag.jpg')" alt="Deutsche Flagge"/></a></li>
				</ul>
			</div>
			<div class="menu-button-nav"><span class="menu-button"><i class="fa fa-bars"></i> Menu</span></div>  
			<!-- <div id="google_translate_element" style="float:right; display:none;"><div class="skiptranslate goog-te-gadget" dir="ltr" style=""><div id=":0.targetLanguage" class="goog-te-gadget-simple" style="white-space: nowrap;"><img src="https://www.google.com/images/cleardot.gif" class="goog-te-gadget-icon" alt="" style="background-image: url(&quot;https://translate.googleapis.com/translate_static/img/te_ctrl3.gif&quot;); background-position: -65px 0px;"><span style="vertical-align: middle;"><a aria-haspopup="true" class="goog-te-menu-value" href="javascript:void(0)"><span>Selecteer een taal</span><img src="https://www.google.com/images/cleardot.gif" alt="" width="1" height="1"><span style="border-left: 1px solid rgb(187, 187, 187);">&#8203;</span><img src="https://www.google.com/images/cleardot.gif" alt="" width="1" height="1"><span aria-hidden="true" style="color: rgb(118, 118, 118);">▼</span></a></span></div></div></div>
			<script type="text/javascript">
				$(window).load(function () {

					if (navigator.userAgent.indexOf('Safari') != -1 && navigator.userAgent.indexOf('Chrome') == -1) {
						$('#google_translate_element').show();
						$('.translation-icons').hide();
					}

					$('.translation-icons').css('visibility', 'visible');

					$('.translation-icons a').click(function(e) {
						e.preventDefault();
						var placement = $(this).data('placement');
						var lang_num = $('.translation-icons a').length;
						var frame = $('.goog-te-menu-frame:first');

						if (!frame.size()) {
							alert("Error: Could not find Google translate frame.");
							return false;
						}

						var langs = $('.goog-te-menu-frame:first').contents().find('a span.text');

						if(langs.length != lang_num) placement = placement+1;

						langs.eq(placement).click();
						return false;
					});

				});
			</script>
			<!-- END GOOGLE TRANSLATE --> 

			
			</div> -->
		</div>
    </div>
  </div>
</div>

<div class="mobilemenu-menu">
	<div class="container">
		<div class="row">
			<div class="col-xs-12">
				<% loop Menu(1) %>
					<a href="$Link" class="button">$MenuTitle</a>
				<% end_loop %>
				<div class="children">
					<p href="$Link" class="button">Andere Städte</p>
					<div class="dropdown">
					<% loop $SubsiteList %>
						<% if $Top.Subsite.ID != $ID %>
						<a href="https://www.$Domain" class="button">$Title</a>
						<% end_if %>
					<% end_loop %>						
					</div>				
				</div>					
			</div>
		</div>
	</div>
</div>

<% if ClassName == "HomePage" || isDataobject == "true" %>
<div class="mobilemenu-filter">
	<div class="container">
		<div class="row">
			<div class="col-xs-12">
				<div class="filter">
					<b>Filter</b>
					<!--<div id="map_canvas2" style="width: 100%; height: 150px; position: relative; overflow: hidden;"></div>-->
					$ProjectenResultsForm	
				</div>
			</div>
		</div>
	</div>
</div>
<% end_if %>

<div class="mobilemenu">
	<div class="container">
		<div class="row">
			<div class="col-xs-6 text-left">
				<% if ClassName == "HomePage" || isDataobject == "true"  %>
				<span class="filter-button"><i class="fa fa-search"></i>Filteren</span>
				<% end_if %>				
			</div>
		</div>
	</div>
</div>
