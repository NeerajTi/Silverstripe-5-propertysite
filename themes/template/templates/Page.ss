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
        <% if $CannonicalURL %>
        <link rel="canonical" href="$CannonicalURL" />
        <% end_if %>
        <meta property="og:locale" content="$ContentLocale" />
        <meta property="og:type" content="website" />
        <meta property="og:title" content="<% if $MetaTitle %>$MetaTitle<% else %>$Title<% end_if %>"/>
        <meta property="og:description" content="$MetaDescription" />
        <meta property="og:url" content="<% if $ClassName == "HomePage" %>$BaseURL<% else %>$AbsoluteLink<% end_if %>" />
        <% if $SiteConfig.Title %><meta property="og:site_name" content="$SiteConfig.Title" /><% end_if %>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <meta name="facebook-domain-verification" content="$Siteconfig.MetaTag" />
        <meta name="theme-color" content="#d6820b" /> 
        <link rel="shortcut icon" href="$SiteConfig.Favicon.URL" />
        $Vite.HeaderTags.RAW
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <% require css('themes/template/css/custom.css') %>
        <% require css('themes/template/css/owl.carousel.min.css') %>
        <% require css('themes/template/css/easy-responsive-tabs.css') %>
        <% require css('themes/template/css/all.min.css') %>

        <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
    </head>
    <body class="$ClassName.ShortName<% if not $Menu(2) %> no-sidebar<% end_if %>" <% if $i18nScriptDirection %>dir="$i18nScriptDirection"<% end_if %>>
    $SiteConfig.TagmanagerOnder.RAW
    <!-- Cookie Consent by TermsFeed https://www.TermsFeed.com -->
<script type="text/javascript" src="//www.termsfeed.com/public/cookie-consent/4.1.0/cookie-consent.js" charset="UTF-8"></script>
<script type="text/javascript" charset="UTF-8">
document.addEventListener('DOMContentLoaded', function () {
cookieconsent.run({"notice_banner_type":"simple","consent_type":"express","palette":"light","language":"de","page_load_consent_levels":["strictly-necessary"],"notice_banner_reject_button_hide":false,"preferences_center_close_button_hide":false,"page_refresh_confirmation_buttons":false,"website_privacy_policy_url":"/datenschutzerklaerung"});
});
</script>
        <% include Header %>
        <%-- include BreadCrumbs --%>
            $Layout
        <% include Footer %>

<%--        <script type="module" src="$themedResourceURL('dist/js/main.js')" defer></script>--%>
        $Vite.BodyTags.RAW

        <script type="text/javascript">
        function googleTranslateElementInit() {
        new google.translate.TranslateElement({pageLanguage: 'de'}, 'google_translate_element');
        }
        </script>
        <script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
		<script src="https://wmb.newsoftdemo.info/themes/template/js/owl.carousel.min.js"></script>
        <script src="https://wmb.newsoftdemo.info/themes/template/js/easy-responsive-tabs.js"></script>
        <script src="https://wmb.newsoftdemo.info/themes/template/js/global.js"></script>
    </body>
</html>
