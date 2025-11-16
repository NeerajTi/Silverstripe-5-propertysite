<!DOCTYPE html>

<html lang="$ContentLocale">
<head>
	<script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-7837477827572257"
     crossorigin="anonymous"></script>
	$SiteConfig.TagmanagerBoven.RAW
	<% base_tag %>
	<% if $VolledigeURL == Succes %>
		<title><% if $MetaTitle %>$MetaTitle<% else %>$Title<% end_if %><% if $Kamer%> <% with Kamer %>| $Type $Title $City<% end_with %><% end_if %></title>
	<% else %>
		<title><% if $MetaTitle %>$MetaTitle<% else %>$Title<% end_if %></title>
	<% end_if %>
	<meta name="description" content="$MetaDescription">
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="facebook-domain-verification" content="$Siteconfig.MetaTag" />
	<script type="text/javascript" src="$themedResourceURL('javascript/jquery-1.9.1.js')"></script>
    <link rel="stylesheet" href="$themedResourceURL('css/bootstrap.min.css')">
    <link rel="stylesheet" href="$themedResourceURL('css/bootstrap-social.css')">
    <link rel="stylesheet" href="$themedResourceURL('css/font-awesome.min.css')">
    <link rel="stylesheet" href="$themedResourceURL('css/flexslider.css')">
    <link rel="stylesheet" href="$themedResourceURL('css/custom.css')">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/glightbox/dist/css/glightbox.min.css" />
	<link rel="shortcut icon" href="$SiteConfig.Favicon.Url" />


<%--	<!-- Facebookpixels -->--%>
<%--	<!-- Meta Pixel Code -->--%>
<%--	<script>--%>
<%--	!function(f,b,e,v,n,t,s)--%>
<%--	{if(f.fbq)return;n=f.fbq=function(){n.callMethod?--%>
<%--	n.callMethod.apply(n,arguments):n.queue.push(arguments)};--%>
<%--	if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';--%>
<%--	n.queue=[];t=b.createElement(e);t.async=!0;--%>
<%--	t.src=v;s=b.getElementsByTagName(e)[0];--%>
<%--	s.parentNode.insertBefore(t,s)}(window, document,'script',--%>
<%--	'https://connect.facebook.net/en_US/fbevents.js');--%>
<%--	fbq('init', '$SiteConfig.FacebookPixels');--%>
<%--	fbq('track', 'PageView');--%>
<%--	</script>--%>
<%--	<noscript><img height="1" width="1" style="display:none"--%>
<%--	src="https://www.facebook.com/tr?id=$SiteConfig.FacebookPixels&ev=PageView&noscript=1"--%>
<%--	/></noscript>--%>
<%--	<!-- End Meta Pixel Code -->--%>
<%--	<!-- Einde Facebookpixels -->--%>

<!-- google maps -->
	<!-- <script
src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB_VkiOkrpidzMdx30MxadRY8rbIlWwayU&callback=initMap&libraries=&v=weekly"
defer
></script> -->
</head>
<body class="$ClassName">
	$SiteConfig.TagmanagerOnder.RAW
		<div class="socials">
	  <ul>
	  <% if $SiteConfig.FacebookPageURL %><li><a href="$SiteConfig.FacebookPageURL" target="_blank"><img src="public/assets/facebook.png" alt="Facebook Logo"/></a></li><% end_if %>
	  <% if $SiteConfig.InstagramPageURL%><li><a href="$SiteConfig.InstagramPageURL" target="_blank"><img src="public/assets/instagram.png" alt="Instagram Logo"/></a></li><% end_if %>
	  </ul>
	  </div>
	<% include Header %>

	<% include BreadCrumbs %>
	$Layout
	<% include Footer %>
</body>
	<script type="text/javascript" src="$themedResourceURL('javascript/bootstrap.min.js')"></script>
	<script type="text/javascript" src="$themedResourceURL('javascript/jquery.flexslider.js')"></script>
	<script type="text/javascript" src="$themedResourceURL('javascript/jquery.cookiebar.js')"></script>
	<script type="text/javascript" src="$themedResourceURL('javascript/custom.js')"></script>
	<script src="https://cdn.jsdelivr.net/gh/mcstudios/glightbox/dist/js/glightbox.min.js"></script>

	<script>
		const glightbox = GLightbox({
    touchNavigation: true,
    loop: true,
    autoplayVideos: true
});
	</script>
</html>
