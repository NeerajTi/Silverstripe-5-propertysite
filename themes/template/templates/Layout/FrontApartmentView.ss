<% include MainHeader %>
<% include Header %>

<style>
.frontend-apartment-gallery {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
}
</style>

<div class="single_details white_bg">
    <div class="container">

        <!-- Back button + Wishlist -->
        <div class="backtolist hide-on-mobile">
            <div class="back_btn">
                <a href="javascript:history.back();">
                    <i class="fa-solid fa-arrow-left"></i> Zurück zum Überblick
                </a>
            </div>
        
        </div>

        <!-- Title -->
		<div class="back_btn show-on-mobile"><a href="javascript:void(0);" onclick="window.history.back();" class="back-link"><i class="fa-solid fa-arrow-left"></i> <h1 class="aanbod-heading">$Title</h1></a></div>
        <h1 class="aanbod-heading hide-on-mobile">$Title</h1>

        <!-- Flash message -->
        <% if $ApartmentFlashMessage %>
            <div class="alert alert-success">$ApartmentFlashMessage</div>
        <% end_if %>

        <div class="project_information_wrapper">
            <!-- Image gallery -->
            <div class="col-5">
                <% if $Apartment.Bilder.Exists %>
                    <div class="swiper-container main-gallery">
                        <div class="swiper-wrapper">
                            <% loop $Apartment.Bilder %>
                                <div class="swiper-slide">
                                    <a href="$URL" class="glightbox3" data-gallery="glightbox3" title="$Title">
                                        <img class="img-fluid lazy" src="$URL" alt="$Title">
                                    </a>
                                </div>
                            <% end_loop %>
                        </div>
                    </div>

                    <div class="swiper-container thumb-gallery">
                        <div class="swiper-wrapper">
                            <% loop $Apartment.Bilder %>
                                <div class="swiper-slide">
                                    <img class="img-fluid lazy" src="$URL" alt="$Title">
                                </div>
                            <% end_loop %>
                        </div>
                    </div>
                <% end_if %>
            </div>

			<div class="d-flex gap-5 show-on-mobile">
				<div class="price">
					€ $Apartment.Details.Kaltmiete <span>p/m</span>
				</div>
				<div class="favoriten">
					<% if $Top.isLoggedIn %>
						<a href="javascript:void(0)" class="add-to-wishlist" data-objectID="$Apartment.ID">
							<% if $Apartment.IsWishlist %>
								<i class="fa-solid fa-heart wishlist"></i>
							<% else %>
								<i class="fa-regular fa-heart wishlist "></i>
							<% end_if %>
						</a>
					<% else %>
						<a href="/login" data-bs-toggle="tooltip" data-bs-placement="top" title="Please login to add to wishlist">
							<i class="fa-regular fa-heart wishlist"></i>
						</a>
					<% end_if %>
					<span>Favoriten</span>
				</div>
			</div>

            <!-- Apartment details -->
            <div class="col-7">
                <div class="row">
                    <div class="col-6">
                        <div id="mymap-canvas">
                            <iframe border="0" frameborder="0"
                                src="https://www.google.com/maps/embed/v1/place?q=$Apartment.Address.GoogleAddress&amp;key=AIzaSyCfb-eiIrgMep_e9DbwR0z8SFuDA4YulbM">
                            </iframe>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="project_details">
                            <div class="price hide-on-mobile">
                                € $Apartment.Details.Kaltmiete <span>p/m</span>
                            </div>

                            <div class="details_cards">
                                <div class="wrap">
                                    <div class="label">Type:</div>
                                    <div class="value">$Apartment.WohnungType</div>
                                </div>
                                <div class="wrap">
                                    <div class="label">Verfügbar</div>
                                    <div class="value">$Apartment.Details.FloorVerfugbarAb</div>
                                </div>
                                <div class="wrap">
                                    <div class="label">Adresse</div>
                                    <div class="value">$Apartment.Address.Street</div>
                                </div>
                                <div class="wrap">
                                    <div class="label">Wohnungseigentum</div>
                                    <div class="value">$Apartment.Details.Wohnflache m²</div>
                                </div>
                                <div class="wrap">
                                    <div class="label">Postleitzahl</div>
                                    <div class="value">$Apartment.Address.Plz</div>
                                </div>
                                <div class="wrap">
                                    <div class="label">Stadt</div>
                                    <div class="value">$Apartment.Address.Stadt</div>
                                </div>
                                <div class="wrap">
                                    <div class="label">Stadtteil</div>
                                    <div class="value">$Apartment.Address.Stadtteil</div>
                                </div>
                            </div>

                            <div class="default_btn">
                                <% if $isLoggedIn %>
                                    <% if $LoginUser.InseriereAls == 'renter' && $LoggedINSubscrptionStatus == 'Active' %>
                                        <a class="button" href="/stadtteile-berlins/contact-apartment/$Apartment.ID">
                                            Auf dieser Wohnung reagieren
                                        </a>
                                    <% else %>
                                  <% if $LoginUser.InseriereAls=='broker' || $LoginUser.InseriereAls=='owner' || $LoginUser.InseriereAls=='seller' %>
                                     <% if $Apartment.MemberID==$LoginUser.MemberID %>
                                  <a class="button" href="/apartment/step1/?apartmentID=$Apartment.ID">
                                            Wohnung bearbeiten
                                        </a>
                                        <% else %>
                                          <a class="button" href="/renter-dashboard/subscription"
                                           data-bs-toggle="popover"
                                           data-bs-placement="bottom"
                                           data-bs-content="Please login as Renter and pay membership fee to contact">
                                            Auf dieser Wohnung reagieren
                                        </a>
                                        <% end_if %>
                                  <% else %>
                                        <a class="button" href="/renter-dashboard/subscription"
                                           data-bs-toggle="popover"
                                           data-bs-placement="bottom"
                                           data-bs-content="Please login as Renter and pay membership fee to contact">
                                            Auf dieser Wohnung reagieren
                                        </a>
                                      <% end_if %>
                                    <% end_if %>
                                <% else %>
                                    <a class="button" href="/login" data-bs-toggle="modal" data-bs-target="#loginModal">
                                        Auf dieser Wohnung reagieren
                                    </a>
                                <% end_if %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<!-- Offered by -->
<div class="offerdby">
    <div class="container">
		<div class="col-9">
			<div class="content">$Apartment.Mietwohnung</div>
		</div>
		<div class="col-3">
			<div class="offerd_user">
				<h3>Angeboten durch:</h3>
				<div class="user_pic">
					<% if $aptUserType == 'broker' %>
						<% if $company.Image %>
							<img src="$company.Image.URL" class="rounded-circle" alt="">
						<% end_if %>
					<% else %>
						<% if $company.Bilder %>
							<img src="$company.Bilder.URL" class="rounded-circle" alt="">
						<% end_if %>
					<% end_if %>
				</div>
				<div class="user_details">
                 <% if $isLoggedIn %>
					<h4>
                  
                    <% if $aptUserType == 'broker' %>
                  
                    $membershipData.Firmaname
                    <% else %>
                    $Apartment.Member.FirstName $Apartment.Member.LastName
                    <% end_if %>
                    </h4>
                     <% end_if %>
					<div class="more_appartment">
						<a href="/stadtteile-berlins/list/$BrokerAptSlug">Weitere Wohnungen</a>
					</div>
					<div class="view_contact">
						<a href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#contactModal">Kontaktinformationen anzeigen</a>
					</div>
				</div>
			</div>
		</div>
    </div>
</div>

<!-- Amenities -->
<section class="amenities-section">
    <div class="container">
        <h2 class="amenities-title">Ausstattung</h2>
        <ul class="amenities-list">
            <% if $Apartment.Details.Schlafzimmer %>
                <li><i class="fa fa-bed"></i> $Apartment.Details.Schlafzimmer Schlafzimmer</li>
            <% end_if %>

            <% if $Apartment.Details.Badezimmer %>
                <li><i class="fa fa-bath"></i> $Apartment.Details.Badezimmer Badezimmer</li>
            <% end_if %>

            <% if $DetailOptions %>
                <% loop $DetailOptions %>
                    <% if $Key == 'Gäste WC' %>
                        <li><i class="fa fa-toilet"></i> Gäste-WC</li>
                    <% end_if %>
                    <% if $Key == 'Einbauküche' %>
                        <li><i class="fa fa-utensils"></i> Einbauküche</li>
                    <% end_if %>
                    <% if $Key == 'Keller' %>
                        <li><i class="fa fa-arrow-down"></i> Keller</li>
                    <% end_if %>
                    <% if $Key == 'Balkon/Terrasse' %>
                        <li><i class="fa fa-sun"></i> Balkon/Terrasse</li>
                    <% end_if %>
                    <% if $Key == 'Garten' %>
                        <li><i class="fa fa-tree"></i> Garten</li>
                    <% end_if %>
                    <% if $Key == 'Aufzug' %>
                        <li><i class="fa fa-elevator"></i> Aufzug</li>
                    <% end_if %>
                    <% if $Key == 'Stufenlose Zugang' %>
                        <li><i class="fa fa-stairs"></i> Stufenlose Zugang</li>
                    <% end_if %>
                    <% if $Key == 'Bohnberchtigungsschein' %>
                        <li><i class="fa fa-wheelchair"></i> Bohnberchtigungsschein</li>
                    <% end_if %>
                    <% if $Key == 'Haustiere erlaubt' %>
                        <li><i class="fa fa-dog"></i> Haustiere erlaubt</li>
                    <% end_if %>
                    <% if $Key == 'WG geeignet' %>
                        <li><i class="fa fa-users"></i> WG Geeignet</li>
                    <% end_if %>
                <% end_loop %>
            <% end_if %>

            <% if $Apartment.Internetgeschwindigkeit %>
                <li><i class="fa fa-wifi"></i> $Apartment.Internetgeschwindigkeit</li>
            <% end_if %>

            <% if $Apartment.Energieeffiziezklasse %>
                <li><i class="fa fa-leaf"></i> Energieeffizienzklasse $Apartment.Energieeffiziezklasse</li>
            <% end_if %>
        </ul>
    </div>
</section>

<!-- Further info -->
<section class="furthe_info">
    <div class="container">
        <h2>Weitere Informationen</h2>
        <div class="content">$Apartment.Mietwohnung</div>
    </div>
</section>
<! Contact Model -->
<div class="modal fade" id="contactModal" tabindex="-1" aria-labelledby="contactModalLabel" aria-hidden="true">
    <div class="modal-dialog model-sm" s>
        <div class="global_custom_form white_100 width_1360 pl_60 pr_60">
            <div class="container">
                
                <div class="row">
                    <div class="col-12">
                      <% if $isLoggedIn %>
                      <div>
                      <% else %>
                      <div class="blurdiv">
                      <% end_if %>
                      	<div class="information">
                        <div class="name">
                        <b>$membershipData.FirstName $membershipData.LastName</b>
                        </div>
									<div class="address">Adresse: $company.Strabe,$company.Nr,$company.Plz,$company.Ort,$company.Land</div>
									<div class="email">Email: $company.Email</div>
									<div class="phone">Telefon: $company.CountryCode $company.Telefon</div>
								</div>
                      </div>
                    </div>
                  
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<! end Contact Model -->
<!-- Login modal -->
<div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="max-width: 100%; margin-top:12%;">
        <div class="global_custom_form white_100 width_1360 pl_60 pr_60">
            <div class="container">
                <h1>Um diese Wohnung anzusehen, brauchen Sie einen Account</h1>
                <div class="row">
                    <div class="col-md-6 order-2 order-sm-1">
                        <div class="benefits_accounts">
                            <h2>Vorteile eines Accounts</h2>
                            <ul>
                                <li>Vorteil 1</li>
                                <li>Vorteil 2</li>
                                <li>Vorteil 3</li>
                                <li>Vorteil 4</li>
                                <li>Vorteil 5</li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-md-6 order-1 order-sm-2">
                        <div class="create_account">
                            <h2>Neuen Account erstellen</h2>
                            <div class="default_btn"><a href="/registration/">Jetzt registrieren</a></div>
                            <h3>Bereits registriert?</h3>
                            <div class="default_outline_btn"><a href="/login/">Einloggen</a></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Scripts -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
<script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/glightbox/dist/css/glightbox.min.css" />
<script src="https://cdn.jsdelivr.net/npm/glightbox/dist/js/glightbox.min.js"></script>

<script>
    const thumbSwiper = new Swiper('.thumb-gallery', {
        spaceBetween: 12,
        slidesPerView: 4,
        freeMode: true,
        watchSlidesProgress: true,
        navigation: {
            nextEl: '.swiper-thumb-next',
            prevEl: '.swiper-thumb-prev',
        },
    });

    const mainSwiper = new Swiper('.main-gallery', {
        spaceBetween: 10,
        thumbs: {
            swiper: thumbSwiper,
        },
    });

    const lightbox = GLightbox({
        selector: '.glightbox3',
        loop: true,
    });
</script>

<% include Footer %>
<% include MainFooter %>
