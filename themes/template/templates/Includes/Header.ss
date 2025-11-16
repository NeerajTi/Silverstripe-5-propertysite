<header id="header" class="main-header">
	<div class="container">
		<div class="logo">
			<a href="$BaseHref">
				<img src="/themes/template/images/logo.png" alt="Wohnung mieten Berlin">
				<span class="site-name">Wohnung mieten Berlin.de</span>
			</a>
		</div>
		<nav class="navbar navbar-expand-xl navbar-dark bg-gray">
			<div class="inner d-xl-flex align-items-center">
				<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#main_nav"
						aria-expanded="false" aria-label="Toggle navigation">
					<span class=""><svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" viewBox="0 0 24 24"><path
						fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
						d="M3 17h18M3 12h18M3 7h18"/></svg></span>
				</button>
				<div class="collapse navbar-collapse d-xl-flex <% if $ClassName == "HomePage" %>justify-content-center<% else %>justify-content-end<% end_if %> " id="main_nav">
					<ul class="navbar-nav <% if $ClassName == "HomePage" %><% else %>m-auto<% end_if %> mt-3 mt-lg-0">
						<% loop $Menu(1) %>
							<% if Children %>
								<li class="nav-item dropdown">
									<a class="nav-link" href="$link"> $MenuTitle.XML </a>
									<!-- <ul class="dropdown-menu dropdown-menu-right" style="overflow-y: scroll; max-height: 80dvh;">
										<% loop Children %>
											<% if Children %>
												<li><a class="dropdown-item" href="$link"> $MenuTitle.XML &raquo; </a>
													<ul class="submenu submenu-left dropdown-menu">
														<li class="d-flex align-items-center">
															<a class="dropdown-item border-bottom" href="$link">$MenuTitle.XML</a>
														</li>
														<% loop Children %>
															<li><a class="dropdown-item fs-7" href="$link">$MenuTitle.XML</a></li>
														<% end_loop %>
													</ul>
												</li>
											<% else %>
												<li class="two-columns"><a class="dropdown-item" href="$link"> $MenuTitle.XML </a></li>
											<% end_if %>
										<% end_loop %>
									</ul> -->
								</li>
							<% else %>
								<li class="nav-item"><a
									class="nav-link "
									href="$link"> $MenuTitle.XML </a></li>
							<% end_if %>
						<% end_loop %>

						<!-- <li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown">Andere Städte</a>
							<ul class="submenu submenu-left dropdown-menu">
								<% loop $SubsiteList %>
									<% if $Top.Subsite.ID != $ID %>
									<li class="d-flex align-items-center stadte-list">  
										<a href="https://$Domain" class="dropdown-item border-bottom">$Title</a>
									</li>
									<% end_if %>
								<% end_loop %>
							</ul>
						</li> -->
						<!-- <li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown">Andere Länder</a>
							<ul class="submenu submenu-left dropdown-menu">
									<li class="d-flex align-items-center"><a href="https://www.pisoenalquilermadrid.es/" target="_blank" class="dropdown-item border-bottom">Spanien</a></li>
									<li class="d-flex align-items-center"><a href="https://www.kameramsterdam.com/" target="_blank" class="dropdown-item border-bottom">Niederlande</a></li>
									<li class="d-flex align-items-center"><a href="https://www.wohnungmietenbasel.ch/" target="_blank" class="dropdown-item border-bottom">Schweiz</a></li>
									<li class="d-flex align-items-center"><a href="https://www.appartamentoaffittoroma.it/" target="_blank" class="dropdown-item border-bottom">Italien</a></li>
							</ul>
						</li> -->
						<!-- <li class="nav-item ml-2"><div id="google_translate_element"></div></li> -->
					</ul>
				</div>
			</div>
		</nav>
		<div class="user-info dropdown">
			<% if $CurrentUser %>
				<div class="wrap">
					<button class="dropdown-toggle">
						<i class="fa-solid fa-user"></i>
						<span>$CurrentUser.FirstName</span>
						<i class="fa-solid fa-caret-down"></i>
					</button>
					<div class="en_text">zu meinem umebung</div>
				</div>
				<ul class="dropdown-menu">
					<li><a href="/dashboard"><i class="fa-solid fa-gauge"></i> Dashboard</a></li>
			<li><a href="/Security/logout"><i class="fa-solid fa-sign-out"></i> Logout</a></li>
				</ul>
			<% else %>
				<a href="/login" class="login-link">
					<i class="fa-solid fa-user"></i> <span class="hide-on-mobile">Anmelden</span>
				</a>
			<% end_if %>
		</div>

	</div>
</header>

<!-- Bottom Nav -->
<div class="show-on-mobile">
	<div class="mobile-bottom-nav">
	<a href="#"><i class="fa-solid fa-house"></i></a>
	<a href="#" class="search-icon"><i class="fa-solid fa-magnifying-glass"></i> <i class="fa-solid fa-heart inner-heart"></i></a>
	<a href="#"><i class="fa-solid fa-heart"></i></a>
	<a href="#"><i class="fa-solid fa-user"></i></a>
	</div>
</div>
