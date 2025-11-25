<?php

namespace App\Helper;

use SilverStripe\Security\Security;
use SilverStripe\Control\HTTPRequest;
use SilverStripe\ORM\ArrayList;
use SilverStripe\View\ArrayData;
use App\Model\MemberBasicData;
use SilverStripe\Control\Director;
use DateTime;

class GlobalHelper
{
    public static function isloggedin()
    {
        if (Security::getCurrentUser()) {
            return true;
        }
        return false;
    }
    public static function generateUniqueCode($length = 9) {
 $part1 = str_pad(random_int(0, 999), 3, '0', STR_PAD_LEFT);

    // Generate 3 random uppercase letters
    $letters = '';
    for ($i = 0; $i < 3; $i++) {
        $letters .= chr(random_int(65, 90)); // ASCII A–Z
    }

    // Generate last 3 random digits
    $part2 = str_pad(random_int(0, 999), 3, '0', STR_PAD_LEFT);

    // Combine all parts
    return $part1 . $letters . $part2;
  }
    public static function getSubscriptionStatus()
    {

        if (!Security::getCurrentUser()) {

            return 'Inactive';

        }

        $loginUser = MemberBasicData::get()->filter(['MemberID' => GlobalHelper::getLoggedInUser()->ID])->first();
        if (!GlobalHelper::isloggedin() || !$loginUser || ($loginUser->InseriereAls != 'renter' && $loginUser->InseriereAls != 'owner' && $loginUser->InseriereAls != 'broker' && $loginUser->InseriereAls != 'seller')) {
            return 'Inactive';
        }

        $SubscrptionStatus = $loginUser->SubscriptionStatus;
        if (!$SubscrptionStatus) {
            return 'Inactive';
        }
        if (!$loginUser->ValidUntil) {
            return 'Inactive';
        }
        $validUntil = new DateTime($loginUser->ValidUntil);
        $now = new DateTime();
        $validSubscription = '';
        if ($loginUser->InseriereAls == 'renter') {
            if ($SubscrptionStatus == 'COMPLETED' && $validUntil >= $now) {
                $validSubscription = 'Active';
            } else {
                $validSubscription = 'Inactive';
            }
        } else {
            if ($SubscrptionStatus == 'COMPLETED' && $loginUser->PlanId == 'Top Platzierung') {
                $validSubscription = 'Active';
            } else {
                $validSubscription = 'Inactive';
            }

        }


        return $validSubscription;
    }

    public static function SelectedPlan($pype = '1 Monate', $type = 'renter', $discount = 0)
    {
        $duration = $pype; // Or get from GET/POST
        $details = self::getPlanDetails($duration, $type, $discount);

        return ArrayData::create($details);
    }
    public static function getLoggedInUser()
    {
        return Security::getCurrentUser();
    }


    public static function getSubscriptionPlans($type = 'renter', $discount = 0)
    {
        $renter = [
            '1 Monate' => ["Price" => 14.95, "discount" => $discount, "ValidUntil" => 30,'Qty' => 1],
            '3 Monate' => ["Price" => 12.95, "discount" => $discount, "ValidUntil" => 90,'Qty' => 3],
            '6 Monate' => ["Price" => 9.95, "discount" => $discount, "ValidUntil" => 180,'Qty' => 6]
        ];

        $owner = [
            'Kostenfrei vermieten' => ["Price" => 0, "discount" => $discount, "ValidUntil" => 1,'Qty' => 1],
            'Top Platzierung' => ["Price" => 99, "discount" => $discount, "ValidUntil" => 1,'Qty' => 1],
        ];

        $plans = ($type === 'renter') ? $renter : $owner;

        $list = new ArrayList();

        foreach ($plans as $duration => $plan) {
            // Format price to 9,95 format
            $formattedPrice = number_format($plan['Price'], 2, ',', '');

            $list->push(ArrayData::create([
                'Duration' => $duration,
                'Price' => $formattedPrice,
                'RawPrice' => $plan['Price'],
                'Discount' => $plan['discount'],
                'DiscountPrice' => number_format($plan['Price'] - ($plan['Price'] * $discount / 100), 2, ',', ''),
                'ValidUntil' => $plan['ValidUntil'],
                'Qty' => $plan['Qty']
            ]));
        }

        return $list;
    }
    public static function getPlanDetails($duration = '1 Monate', $type = 'renter', $discount = 0)
    {
        $plans = self::getSubscriptionPlans($type, $discount);

        foreach ($plans as $plan) {
            if ($plan->Duration === $duration) {
                return [
                    'Price' => $plan->RawPrice,
                    'Qty' => $plan->Qty,
                    'DiscountPrice' => str_replace(',', '.', $plan->DiscountPrice)
                ];
            }
        }

        return null; // if not found
    }

    public static function getCurrentUserSession(HTTPRequest $request)
    {

        return $request->getSession();
    }
    public static function getCities()
    {


        $cities = [
            "Aachen" => "Aachen",
            "Augsburg" => "Augsburg",
            "Berlin" => "Berlin",
            "Bielefeld" => "Bielefeld",
            "Bochum" => "Bochum",
            "Bonn" => "Bonn",
            "Bremen" => "Bremen",
            "Darmstadt" => "Darmstadt",
            "Dortmund" => "Dortmund",
            "Dresden" => "Dresden",
            "Düsseldorf" => "Düsseldorf",
            "Erfurt" => "Erfurt",
            "Frankfurt" => "Frankfurt",
            "Freiburg" => "Freiburg",
            "Hamburg" => "Hamburg",
            "Hannover" => "Hannover",
            "Heidelberg" => "Heidelberg",
            "Karlsruhe" => "Karlsruhe",
            "Kiel" => "Kiel",
            "Kleve" => "Kleve",
            "Koblenz" => "Koblenz",
            "Köln" => "Köln",
            "Krefeld" => "Krefeld",
            "Leipzig" => "Leipzig",
            "Leverkusen" => "Leverkusen",
            "Lübeck" => "Lübeck",
            "Mainz" => "Mainz",
            "Mannheim" => "Mannheim",
            "München" => "München",
            "Münster" => "Münster",
            "Neuss" => "Neuss",
            "Nürnberg" => "Nürnberg",
            "Oberhausen" => "Oberhausen",
            "Oldenburg" => "Oldenburg",
            "Regensburg" => "Regensburg",
            "Rostock" => "Rostock",
            "Stuttgart" => "Stuttgart",
            "Trier" => "Trier",
            "Ulm" => "Ulm",
            "Wiesbaden" => "Wiesbaden",
            "Würzburg" => "Würzburg"
        ];
          
        return $cities;
    }
    public static function getDistrictbycity($city){
        $district=[
            'Würzburg'=>[
    "Altstadt",
    "Zellerau",
    "Sanderau",
    "Frauenland",
    "Heidingsfeld",
    "Heuchelhof",
    "Steinbachtal",
    "Grombühl",
    "Lindleinsmühle",
    "Lengfeld",
    "Versbach",
    "Unterdürrbach",
    "Oberdürrbach"
            ],
            'Wiesbaden'=>[
    "Auringen",
    "Biebrich",
    "Bierstadt",
    "Breckenheim",
    "Delkenheim",
    "Dotzheim",
    "Erbenheim",
    "Frauenstein",
    "Freudenberg",
    "Heßloch",
    "Igstadt",
    "Klarenthal",
    "Kloppenheim",
    "Kostheim (Wiesbadener Teil)",
    "Mainz-Kastel",
    "Mainz-Kostheim",
    "Medenbach",
    "Naurod",
    "Nordost",
    "Nordenstadt",
    "Rheingauviertel/Hollerborn",
    "Schierstein",
    "Sonnenberg",
    "Südost",
    "Westend/Bleichstraße",
    "Wiesbaden-Mitte"
            ],
            'Ulm'=>[
    "Altstadt/Mitte",
    "Böfingen",
    "Donaustetten",
    "Einsingen",
    "Eggingen",
    "Ermingen",
    "Eselsberg",
    "Gögglingen",
    "Grimmelfingen",
    "Jungingen",
    "Lehr",
    "Mähringen",
    "Oststadt",
    "Söflingen",
    "Unterweiler",
    "Weststadt",
    "Wiblingen",
    "Westerwinkel"
],
            'Trier'=>[
    "Mitte-Gartenfeld",
    "Nord",
    "Innenstadt",
    "Ost",
    "Süd",
    "West-Pallien",
    "Ehrang",
    "Quint",
    "Biewer",
    "Pfalzel",
    "Ruwer/Eitelsbach",
    "Kürenz",
    "Tarforst",
    "Irsch",
    "Filsch",
    "Olewig",
    "Heiligkreuz",
    "Mariahof",
    "Tarforst Plateau"
],
            'Stuttgart'=>[
    "Mitte",
    "Nord",
    "Ost",
    "Süd",
    "West",
    "Bad Cannstatt",
    "Birkach",
    "Botnang",
    "Degerloch",
    "Feuerbach",
    "Hedelfingen",
    "Möhringen",
    "Mühlhausen",
    "Münster",
    "Obertürkheim",
    "Plieningen",
    "Sillenbuch",
    "Stammheim",
    "Untertürkheim",
    "Vaihingen",
    "Wangen",
    "Weilimdorf",
    "Zuffenhausen"
            ],
            'Rostock'=>[
    "Altstadt",
    "Stadtmitte",
    "Kröpeliner-Tor-Vorstadt",
    "Steintor-Vorstadt",
    "Gartenstadt",
    "Südstadt",
    "Hansaviertel",
    "Reutershagen",
    "Brinckmansdorf",
    "Toitenwinkel",
    "Dierkow-Neu",
    "Dierkow-Ost",
    "Dierkow-West",
    "Gehlsdorf",
    "Hansaviertel",
    "Evershagen",
    "Lütten Klein",
    "Schmarl",
    "Groß Klein",
    "Lichtenhagen",
    "Warnemünde",
    "Hohe Düne",
    "Markgrafenheide",
    "Peez",
    "Hinrichshagen",
    "Wiethagen",
    "Papendorf (Rostock-Anteil)",
    "Biendorf (Rostock-Anteil)",
    "Riekdahl",
    "Stuthof",
    "Kassebohm"
],
            'Regensburg'=>[
    "Altstadt",
    "Innenstadt",
    "Stadtamhof",
    "Reinhausen",
    "Konradsiedlung-Wutzlhofen",
    "Brandlberg-Keilberg",
    "Sallern-Gallingkofen",
    "Weichs",
    "Am Königswiesen",
    "Kasernenviertel",
    "Galgenberg",
    "Kumpfmühl-Ziegetsberg",
    "Südstadt",
    "Ostenviertel",
    "Großprüfening-Dechbetten-Königswiesen",
    "Oberisling-Leoprechting",
    "Graß",
    "Harting"
            ],
            'Oldenburg'=>[
    "Innenstadt",
    "Osternburg",
    "Donnerschwee",
    "Bürgerfelde",
    "Dietrichsfeld",
    "Alexanderfeld",
    "Tweelbäke",
    "Kreyenbrück",
    "Krusenbusch",
    "Bümmerstede",
    "Kreyenbrück-West",
    "Eversten",
    "Bloherfelde",
    "Wechloy",
    "Nadorst",
    "Ofenerdiek",
    "Etzhorn",
    "Ohmstede",
    "Bornhorst",
    "Neuenwege",
    "Petersfehn (Oldenburg-Anteil)",
    "Haarenesch",
    "Haarentor",
    "Dobbenviertel",
    "Gerichtsviertel",
    "Drielaker Moor",
    "Kloster Blankenburg",
    "Waterende",
    "Bahnhofsviertel",
    "Elisabeth-Anna-Viertel",
    "Sackgasse",
    "Ulmer Ort",
    "Donnerschwee West",
    "Donnerschwee Ost",
    "Wechloy-Süd"
],
            'Oberhausen'=>[
    "Alt-Oberhausen",
    "Marienkirche",
    "Lirich-Süd",
    "Lirich-Mitte",
    "Lirich-Nord",
    "Buschhausen",
    "Biefang",
    "Alstaden-Ost",
    "Alstaden-West",
    "Styrum",
    "Bermensfeld",
    "Schmachtendorf",
    "Holten",
    "Alstaden-Süd",
    "Sterkrade-Mitte",
    "Sterkrade-Süd",
    "Sterkrade-Nord",
    "Klosterhardt-Nord",
    "Klosterhardt-Süd",
    "Alsfeld",
    "Dümpten",
    "Osterfeld-Mitte",
    "Osterfeld-Süd",
    "Osterfeld-Ost",
    "Vondern",
    "Heide"
            ],
            'Nürnberg'=>[
    "Mitte",
    "Nord",
    "Nordost",
    "Ost",
    "Südost",
    "Süd",
    "West"
],
            'Neuss'=>[
    "Innenstadt",
    "Barbaraviertel",
    "Dreikönigenviertel",
    "Augustinusviertel",
    "Gnadental",
    "Vogelsang",
    "Weißenberg",
    "Grimlinghausen",
    "Uedesheim",
    "Reuschenberg",
    "Weckhoven",
    "Hoisten",
    "Speck",
    "Wehl",
    "Helpenstein",
    "Holzheim",
    "Grefrath",
    "Norf",
    "Derikum",
    "Erfttal",
    "Rosellen",
    "Rosellerheide",
    "Schlicherum",
    "Hoisten",
    "Allerheiligen",
    "Elvekum",
    "Hoisten",
    "Schlicherum"
],
            'Münster'=> [
    "Mitte",
    "Nord",
    "West",
    "Hiltrup",
    "Südost",
    "Wolbeck"
],
            'München'=>[
    "Altstadt-Lehel",
    "Ludwigsvorstadt-Isarvorstadt",
    "Maxvorstadt",
    "Schwabing-West",
    "Au-Haidhausen",
    "Sendling",
    "Sendling-Westpark",
    "Schwanthalerhöhe",
    "Neuhausen-Nymphenburg",
    "Moosach",
    "Milbertshofen-Am Hart",
    "Schwabing-Freimann",
    "Bogenhausen",
    "Berg am Laim",
    "Trudering-Riem",
    "Ramersdorf-Perlach",
    "Obergiesing-Fasangarten",
    "Untergiesing-Harlaching",
    "Thalkirchen-Obersendling-Forstenried-Fürstenried-Solln",
    "Hadern",
    "Pasing-Obermenzing",
    "Aubing-Lochhausen-Langwied",
    "Allach-Untermenzing",
    "Feldmoching-Hasenbergl",
    "Laim"
],
            'Mannheim'=>[
    "Innenstadt/Jungbusch",
    "Neckarstadt-West",
    "Neckarstadt-Ost/Wohlgelegen",
    "Schönau",
    "Waldhof",
    "Sandhofen",
    "Blumenau",
    "Käfertal",
    "Vogelstang",
    "Wallstadt",
    "Feudenheim",
    "Seckenheim",
    "Friedrichsfeld",
    "Rheinau",
    "Neckarau",
    "Lindenhof",
    "Neuostheim/Neuhermsheim"
],
            'Mainz'=>[
    "Altstadt",
    "Neustadt",
    "Oberstadt",
    "Bretzenheim",
    "Mombach",
    "Hartenberg-Münchfeld",
    "Gonsenheim",
    "Finthen",
    "Drais",
    "Lerchenberg",
    "Marienborn",
    "Ebersheim",
    "Laubenheim",
    "Hechtsheim",
    "Weisenau"
],
            'Lübeck'=>[
    "Innenstadt",
    "St. Jürgen",
    "Moisling",
    "Buntekuh",
    "St. Lorenz Süd",
    "St. Lorenz Nord",
    "Schlutup",
    "Kücknitz",
    "Travemünde",
    "Karlshof-Israelsdorf",
    "Herrenwyk",
    "Dänischburg",
    "Alt-Travemünde/Rönnau",
    "Ivendorf",
    "Siems",
    "Rangenberg",
    "Wallberg",
    "Kücknitz-Dorf",
    "Pöppendorf",
    "Brandenbaum",
    "Gothmund",
    "Eichholz",
    "Marli",
    "Wulfsdorf",
    "Beidendorf",
    "Palingen (Lübecker Teil)",
    "Blankensee-Airport Area",
    "Vorwerk",
    "Genin",
    "Rehderstieg",
    "Niendorf",
    "Krummesse (Lübecker Teil)",
    "Steinrade",
    "Einsiedel",
    "Israelsdorf"
],
            'Leverkusen'=>[
    "Wiesdorf",
    "Manfort",
    "Rheindorf",
    "Opladen",
    "Küppersteg",
    "Bürrig",
    "Quettingen",
    "Bergisch Neukirchen",
    "Hitdorf",
    "Steinbüchel",
    "Lützenkirchen",
    "Schlebusch",
    "Alkenrath"
],
            'Leipzig'=>[
    "Mitte",
    "Nord",
    "Nordost",
    "Ost",
    "Südost",
    "Süd",
    "Südwest",
    "West",
    "Altwest",
    "Nordwest"
],
            'Krefeld'=>[
    "Bockum",
    "Dießem/Lehmheide",
    "Fischeln",
    "Gartenstadt",
    "Gellep-Stratum",
    "Hüls",
    "Inrath/Kliedbruch",
    "Kempener Feld/Baackeshof",
    "Linn",
    "Oppum",
    "Traar",
    "Uerdingen",
    "Verberg",
    "Benrad-Nord",
    "Benrad-Süd",
    "Cracau",
    "Elfrath",
    "Forstwald",
    "Lindental"
],
            'Köln'=>[
    "Innenstadt",
    "Rodenkirchen",
    "Lindenthal",
    "Ehrenfeld",
    "Nippes",
    "Chorweiler",
    "Porz",
    "Kalk",
    "Mülheim"
            ],
            'Koblenz'=>[
    "Altstadt",
    "Innenstadt",
    "Pfaffendorfer Höhe",
    "Südliche Vorstadt",
    "Goldgrube",
    "Oberwerth",
    "Karthause",
    "Asterstein",
    "Ehrenbreitstein",
    "Niederberg",
    "Arzheim",
    "Metternich",
    "Rübenach",
    "Güls",
    "Neuendorf",
    "Lützel",
    "Wallersheim",
    "Bubenheim",
    "Mülheim-Kärlich (Koblenzer Anteil)",
    "Münstermaifeld (Koblenzer Anteil)",
    "Horchheim",
    "Moselweiss",
    "Stolzenfels",
    "Lay",
    "Arenberg",
    "Immendorf",
    "Wolken (Koblenzer Anteil)",
    "Kesselheim",
    "Bisholder",
    "Kondertal"
],
            'Kleve'=>[
    "Kleve",
    "Materborn",
    "Donsbrüggen",
    "Nütterden",
    "Rindern",
    "Keeken",
    "Schenkenschanz",
    "Warbeyen",
    "Brienen",
    "Griethausen",
    "Kellen",
    "Wardhausen",
    "Heide",
    "Reichswalde",
    "Mosserfeld"
],
            'Kiel'=>[
    "Altstadt",
    "Vorstadt",
    "Exerzierplatz",
    "Brunswik",
    "Damperhof",
    "Ravensberg",
    "Blücherplatz",
    "Düsternbrook",
    "Wik",
    "Holtenau",
    "Pries",
    "Friedrichsort",
    "Schilksee",
    "Suchsdorf",
    "Kroog",
    "Hasseldieksdamm",
    "Mettenhof",
    "Russee",
    "Hammer",
    "Moorsee",
    "Gaarden-Ost",
    "Gaarden-Süd/Kronsburg",
    "Ellerbek",
    "Wellingdorf",
    "Neumühlen-Dietrichsdorf",
    "Elmschenhagen-Nord",
    "Elmschenhagen-Süd",
    "Wellsee",
    "Meimersdorf",
    "Hassee"
            ],
            'Karlsruhe'=>[
    "Innenstadt-West",
    "Innenstadt-Ost",
    "Durlach",
    "Grünwinkel",
    "Knielingen",
    "Mühlburg",
    "Nordweststadt",
    "Nordstadt",
    "Oberreut",
    "Oststadt",
    "Rintheim",
    "Südstadt",
    "Südweststadt",
    "Weststadt",
    "Wolfartsweier",
    "Grötzingen",
    "Hohenwettersbach",
    "Stupferich",
    "Neureut",
    "Daxlanden",
    "Weiherfeld-Dammerstock",
    "Rüppurr",
    "Beiertheim-Bulach",
    "Hub",
    "Killisfeld",
    "Waldstadt",
    "Hagsfeld",
    "Palmbach",
    "Grünwettersbach",
    "Stadtmitte",
    "Gewerbegebiet Storrenacker"
],
            'Heidelberg'=>[
    "Altstadt",
    "Bergheim",
    "Weststadt",
    "Südstadt",
    "Rohrbach",
    "Kirchheim",
    "Handschuhsheim",
    "Neuenheim",
    "Wieblingen",
    "Pfaffengrund",
    "Ziegelhausen",
    "Schlierbach",
    "Boxberg",
    "Emmertsgrund",
    "Bahnstadt"
],
            'Hannover'=>[
    "Ahlem-Badenstedt-Davenstedt",
    "Bothfeld-Vahrenheide",
    "Buchholz-Kleefeld",
    "Herrenhausen-Stöcken",
    "Kirchrode-Bemerode-Wülferode",
    "Linden-Limmer",
    "Misburg-Anderten",
    "Mitte",
    "Nord",
    "Ricklingen",
    "Südstadt-Bult",
    "Vahrenwald-List",
    "Wettbergen-Mühlenberg"
            ],
            'Hamburg'=>[
    "Hamburg-Mitte",
    "Hamburg-Altona",
    "Hamburg-Eimsbüttel",
    "Hamburg-Nord",
    "Hamburg-Wandsbek",
    "Hamburg-Bergedorf",
    "Hamburg-Harburg"
            ],
            'Freiburg'=>[
    "Altstadt",
    "Neuburg",
    "Herdern",
    "Zähringen",
    "Brühl",
    "Stühlinger",
    "Mooswald",
    "Betzenhausen",
    "Lehen",
    "Landwasser",
    "Wiehre",
    "Oberau",
    "Waldsee",
    "Littenweiler",
    "Günterstal",
    "Haslach",
    "Weingarten",
    "Rieselfeld",
    "St. Georgen",
    "Kappel",
    "Ebnet",
    "Hochdorf",
    "Mundenhof",
    "Opfingen",
    "Tiengen",
    "Waltershofen",
    "St. Nikolaus",
    "Brühl-Beurbarung"
],
            'Frankfurt'=>[
    "Altstadt",
    "Innenstadt I",
    "Innenstadt II",
    "Innenstadt III",
    "Bornheim/Ostend",
    "Nord-End",
    "West-End",
    "Sachsenhausen",
    "Gutleutviertel/Gallus",
    "Bockenheim",
    "Rödelheim",
    "Hausen",
    "Höchst",
    "Sindlingen/Zeilsheim",
    "Nied",
    "Sossenheim"
            ],
            'Erfurt'=>[
    "Altstadt",
    "Andreasvorstadt",
    "Brühlervorstadt",
    "Daberstedt",
    "Dittelstedt",
    "Egstedt",
    "Elxleben",
    "Gispersleben",
    "Hochheim",
    "Ilversgehofen",
    "Kerspleben",
    "Kleinmölsen",
    "Kühnhausen",
    "Linderbach",
    "Löbervorstadt",
    "Marbach",
    "Mittelhausen",
    "Möbisburg-Rhoda",
    "Monstab",
    "Moskauer Platz",
    "Niedernissa",
    "Nord",
    "Oststadt",
    "Roter Berg",
    "Rohda (Haarberg)",
    "Salomonsborn",
    "Schaderode",
    "Schmira",
    "Schwerborn",
    "Stotternheim",
    "Südost",
    "Südwest",
    "Tiefthal",
    "Töttelstädt",
    "Töttleben",
    "Urbich",
    "Vieselbach",
    "Wallichen",
    "Waltersleben",
    "Walschleben",
    "Wermsdorf",
    "Windischholzhausen",
    "Witterda",
    "Ziegelheim",
    "Ziegenberg",
    "Hochheim",
    "Gispersleben",
    "Krämpfervorstadt",
    "Rieth",
    "Andreasvorstadt"
],
            'Dresden'=>[
    "Altstadt",
    "Blasewitz",
    "Cotta",
    "Klotzsche",
    "Leuben",
    "Loschwitz",
    "Neustadt",
    "Pieschen",
    "Plauen",
    "Prohlis"
            ],
            'Dortmund'=>[
    "Innenstadt-West",
    "Innenstadt-Nord",
    "Innenstadt-Ost",
    "Aplerbeck",
    "Brackel",
    "Eving",
    "Hörde",
    "Hombruch",
    "Huckarde",
    "Lütgendortmund",
    "Mengede",
    "Scharnhorst"
],
            'Darmstadt'=>[
    "Mitte",
    "Nord",
    "Ost",
    "West",
    "Bessungen",
    "Eberstadt",
    "Arheilgen",
    "Kranichstein",
    "Wixhausen"
            ],
            'Bremen'=>[
    "Mitte",
    "Östliche Vorstadt",
    "Schwachhausen",
    "Vahr",
    "Hemelingen",
    "Burglesum",
    "Vegesack",
    "Blumenthal",
    "Walle",
    "Findorff",
    "Gröpelingen",
    "Huchting",
    "Woltmershausen",
    "Seehausen",
    "Strom",
    "Obervieland",
    "Kattenturm",
    "Arsten",
    "Habenhausen",
    "Neustadt",
    "Mahndorf",
    "Kattenesch",
    "Borgfeld"
            ],
            'Bonn'=>[
    "Bonn",
    "Beuel",
    "Bad Godesberg",
    "Hardtberg"
            ],
            'Bochum'=>[
    "Bochum-Mitte",
    "Bochum-Wattenscheid",
    "Bochum-Nord",
    "Bochum-Ost",
    "Bochum-Süd",
    "Bochum-Südwest"
            ],
            'Bielefeld'=>[
    "Bielefeld-Mitte",
    "Brackwede",
    "Dornberg",
    "Gadderbaum",
    "Heepen",
    "Jöllenbeck",
    "Schildesche",
    "Senne",
    "Sennestadt",
    "Stieghorst"
            ],
            'Düsseldorf'=>[
                "Stadtbezirk 1",
    "Stadtbezirk 2",
    "Stadtbezirk 3",
    "Stadtbezirk 4",
    "Stadtbezirk 5",
    "Stadtbezirk 6",
    "Stadtbezirk 7",
    "Stadtbezirk 8",
    "Stadtbezirk 9",
    "Stadtbezirk 10"
            ],
            'Berlin'=>[
     "Mitte",
    "Friedrichshain-Kreuzberg",
    "Pankow",
    "Charlottenburg-Wilmersdorf",
    "Spandau",
    "Steglitz-Zehlendorf",
    "Tempelhof-Schöneberg",          
    "Neukölln",
    "Treptow-Köpenick",
    "Marzahn-Hellersdorf",
    "Lichtenberg",
    "Reinickendorf" 
            ],
    'Aachen'=>["Mitte",               // Central district (city center)
    "Brand",
    "Eilendorf",
    "Haaren",
    "Kornelimünster/Walheim",
    "Laurensberg",
    "Richterich"],
    'Augsburg'=>[
    "Innenstadt",               // City center
    "Lechhausen",
    "Oberhausen",
    "Bärenkeller",
    "Kriegshaber",
    "Pfersee",
    "Göggingen",
    "Haunstetten-Siebenbrunn",
    "Hochzoll",
    "Firnhaberau",
    "Hammerschmiede",
    "Inningen",
    "Bergheim",
    "Hochfeld",
    "Spickel-Herrenbach",
    "Antonsviertel",
    "Universitätsviertel"
     ],
    ];
    return $district[$city] ?? self::getDistrict();    
    }
    public static function getDistrict()
    {
        $berlinDistricts = [
            'Spandau',
            'Neukölln',
            'Zehlendorf',
            'Charlottenburg',
            'Berlin Mitte',
            'Pankow',
            'Prenzlauer Berg',
            'Steglitz',
            'Lichtenrade',
            'Tegel',
            'Kreuzberg',
            'Blankenburg',
            'Kladow',
            'Frohnau',
        ];
        return $berlinDistricts;
    }

    public static function getLatLng($street = '', $city = '', $postcode = '', $country = '', $countryCode = '')
    {
        $baseUrl = "https://nominatim.openstreetmap.org/search";

        // Build query parameters
        $params = [
            'format' => 'json',
            'limit' => 1,
            'addressdetails' => 1
        ];

        // Build the query string from address components
        $queryParts = [];
        if (!empty($street)) {
            $queryParts[] = $street;
        }
        if (!empty($city)) {
            $queryParts[] = $city;
        }
        if (!empty($postcode)) {
            $queryParts[] = $postcode;
        }
        if (!empty($country)) {
            $queryParts[] = $country;
        }

        if (!empty($queryParts)) {
            //$params['q'] = implode(', ', $queryParts);
        }

        // Add structured parameters if available
        if (!empty($street)) {
            $params['street'] = $street;
        }
        if (!empty($city)) {
            $params['city'] = $city;
        }
        if (!empty($postcode)) {
            $params['postalcode'] = $postcode;
        }
        if (!empty($country)) {
            $params['country'] = $country;
        }
        if (!empty($countryCode)) {
            $params['countrycodes'] = $countryCode;
        }

        $url = $baseUrl . '?' . http_build_query($params);

        // Initialize cURL
        $ch = curl_init();

        curl_setopt_array($ch, [
            CURLOPT_URL => $url,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_USERAGENT => 'MyApp/1.0 (neerajtiwari.nethues@gmail.com)',
            CURLOPT_REFERER => self::getBaseURL(),
            CURLOPT_TIMEOUT => 10
        ]);

        $response = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);

        if ($httpCode !== 200 || !$response) {
            return [
                'success' => false,
                'error' => 'HTTP request failed with code: ' . $httpCode
            ];
        }

        $data = json_decode($response, true);

        if (empty($data)) {
            return [
                'success' => false,
                'error' => 'No results found for the given address'
            ];
        }

        $result = $data[0];

        return [
            'success' => true,
            'latitude' => floatval($result['lat']),
            'longitude' => floatval($result['lon']),
            'display_name' => $result['display_name'],
            'address' => $result['address'] ?? [],
            'type' => $result['type'] ?? '',
            'importance' => $result['importance'] ?? 0
        ];
    }
    public static function getBaseURL()
    {
        return Director::absoluteBaseURL();
    }

    public static function getHeizungsarten()
    {
     return [
    "Zentralheizung" => "Zentralheizung",
    "Etagenheizung" => "Etagenheizung",
    "Fernwärme / Nahwärme" => "Fernwärme / Nahwärme",
    "Gasheizung" => "Gasheizung",
    "Ölheizung" => "Ölheizung",
    "Fußbodenheizung" => "Fußbodenheizung",
    "Nachtspeicherheizung / Elektro" => "Nachtspeicherheizung / Elektro",
    "Wärmepumpe" => "Wärmepumpe",
    "Pelletheizung / Holz" => "Pelletheizung / Holz",
    "Blockheizkraftwerk (BHKW)" => "Blockheizkraftwerk (BHKW)"
    ];

    }
    public static function getYears()
    {
        $years = [];
        for($i=1950;$i<=date('Y');$i++){
            $years[$i]=$i;
        }
        return $years;
    }

    public static function getPhoneCodeCountry()
    {
        $countryDialCodes = [
    '+93'   => 'Afghanistan (+93)',
    '+355'  => 'Albania (+355)',
    '+213'  => 'Algeria (+213)',
    '+1‑684' => 'American Samoa (+1‑684)',
    '+376'  => 'Andorra (+376)',
    '+244'  => 'Angola (+244)',
    '+1‑264' => 'Anguilla (+1‑264)',
    '+1‑268' => 'Antigua and Barbuda (+1‑268)',
    '+54'   => 'Argentina (+54)',
    '+374'  => 'Armenia (+374)',
    '+297'  => 'Aruba (+297)',
    '+247'  => 'Ascension Island (+247)',
    '+61'   => 'Australia (+61)',
    '+43'   => 'Austria (+43)',
    '+994'  => 'Azerbaijan (+994)',
    '+1‑242' => 'Bahamas (+1‑242)',
    '+973'  => 'Bahrain (+973)',
    '+880'  => 'Bangladesh (+880)',
    '+1‑246' => 'Barbados (+1‑246)',
    '+375'  => 'Belarus (+375)',
    '+32'   => 'Belgium (+32)',
    '+501'  => 'Belize (+501)',
    '+229'  => 'Benin (+229)',
    '+1‑441' => 'Bermuda (+1‑441)',
    '+975'  => 'Bhutan (+975)',
    '+591'  => 'Bolivia (+591)',
    '+387'  => 'Bosnia & Herzegovina (+387)',
    '+267'  => 'Botswana (+267)',
    '+55'   => 'Brazil (+55)',
    '+673'  => 'Brunei (+673)',
    '+359'  => 'Bulgaria (+359)',
    '+226'  => 'Burkina Faso (+226)',
    '+257'  => 'Burundi (+257)',
    '+855'  => 'Cambodia (+855)',
    '+237'  => 'Cameroon (+237)',
    '+1'    => 'Canada / USA / other NANPA (+1)',
    '+236'  => 'Central African Republic (+236)',
    '+235'  => 'Chad (+235)',
    '+56'   => 'Chile (+56)',
    '+86'   => 'China (+86)',
    '+57'   => 'Colombia (+57)',
    '+269'  => 'Comoros (+269)',
    '+243'  => 'Democratic Republic of the Congo (+243)',
    '+242'  => 'Congo / Republic of the Congo (+242)',
    '+506'  => 'Costa Rica (+506)',
    '+385'  => 'Croatia (+385)',
    '+53'   => 'Cuba (+53)',
    '+357'  => 'Cyprus (+357)',
    '+420'  => 'Czech Republic (+420)',
    '+45'   => 'Denmark (+45)',
    '+253'  => 'Djibouti (+253)',
    '+1‑767' => 'Dominica (+1‑767)',
    '+1‑809' => 'Dominican Republic (+1‑809)',
    '+593'  => 'Ecuador (+593)',
    '+20'   => 'Egypt (+20)',
    '+503'  => 'El Salvador (+503)',
    '+240'  => 'Equatorial Guinea (+240)',
    '+291'  => 'Eritrea (+291)',
    '+372'  => 'Estonia (+372)',
    '+251'  => 'Ethiopia (+251)',
    '+679'  => 'Fiji (+679)',
    '+358'  => 'Finland (+358)',
    '+33'   => 'France (+33)',
    '+241'  => 'Gabon (+241)',
    '+220'  => 'Gambia (+220)',
    '+995'  => 'Georgia (+995)',
    '+49'   => 'Germany (+49)',
    '+233'  => 'Ghana (+233)',
    '+30'   => 'Greece (+30)',
    '+1‑473' => 'Grenada (+1‑473)',
    '+502'  => 'Guatemala (+502)',
    '+224'  => 'Guinea (+224)',
    '+245'  => 'Guinea‑Bissau (+245)',
    '+592'  => 'Guyana (+592)',
    '+509'  => 'Haiti (+509)',
    '+504'  => 'Honduras (+504)',
    '+852'  => 'Hong Kong (+852)',
    '+36'   => 'Hungary (+36)',
    '+354'  => 'Iceland (+354)',
    '+91'   => 'India (+91)',
    '+62'   => 'Indonesia (+62)',
    '+98'   => 'Iran (+98)',
    '+964'  => 'Iraq (+964)',
    '+353'  => 'Ireland (+353)',
    '+972'  => 'Israel (+972)',
    '+39'   => 'Italy (+39)',
    '+1‑876' => 'Jamaica (+1‑876)',
    '+81'   => 'Japan (+81)',
    '+962'  => 'Jordan (+962)',
    '+7'    => 'Kazakhstan / Russia (+7)',
    '+254'  => 'Kenya (+254)',
    '+686'  => 'Kiribati (+686)',
    '+965'  => 'Kuwait (+965)',
    '+996'  => 'Kyrgyzstan (+996)',
    '+856'  => 'Laos (+856)',
    '+371'  => 'Latvia (+371)',
    '+961'  => 'Lebanon (+961)',
    '+266'  => 'Lesotho (+266)',
    '+231'  => 'Liberia (+231)',
    '+218'  => 'Libya (+218)',
    '+423'  => 'Liechtenstein (+423)',
    '+370'  => 'Lithuania (+370)',
    '+352'  => 'Luxembourg (+352)',
    '+853'  => 'Macau (+853)',
    '+389'  => 'North Macedonia (+389)',
    '+261'  => 'Madagascar (+261)',
    '+265'  => 'Malawi (+265)',
    '+60'   => 'Malaysia (+60)',
    '+960'  => 'Maldives (+960)',
    '+223'  => 'Mali (+223)',
    '+356'  => 'Malta (+356)',
    '+692'  => 'Marshall Islands (+692)',
    '+222'  => 'Mauritania (+222)',
    '+230'  => 'Mauritius (+230)',
    '+52'   => 'Mexico (+52)',
    '+691'  => 'Micronesia (+691)',
    '+373'  => 'Moldova (+373)',
    '+377'  => 'Monaco (+377)',
    '+976'  => 'Mongolia (+976)',
    '+382'  => 'Montenegro (+382)',
    '+1‑664' => 'Montserrat (+1‑664)',
    '+212'  => 'Morocco (+212)',
    '+258'  => 'Mozambique (+258)',
    '+95'   => 'Myanmar (+95)',
    '+264'  => 'Namibia (+264)',
    '+674'  => 'Nauru (+674)',
    '+977'  => 'Nepal (+977)',
    '+31'   => 'Netherlands (+31)',
    '+64'   => 'New Zealand (+64)',
    '+505'  => 'Nicaragua (+505)',
    '+227'  => 'Niger (+227)',
    '+234'  => 'Nigeria (+234)',
    '+683'  => 'Niue (+683)',
    '+672'  => 'Norfolk Island (+672)',
    '+850'  => 'North Korea (+850)',
    '+47'   => 'Norway (+47)',
    '+968'  => 'Oman (+968)',
    '+92'   => 'Pakistan (+92)',
    '+680'  => 'Palau (+680)',
    '+970'  => 'Palestine (+970)',
    '+507'  => 'Panama (+507)',
    '+675'  => 'Papua New Guinea (+675)',
    '+595'  => 'Paraguay (+595)',
    '+51'   => 'Peru (+51)',
    '+63'   => 'Philippines (+63)',
    '+48'   => 'Poland (+48)',
    '+351'  => 'Portugal (+351)',
    '+1‑787' => 'Puerto Rico (+1‑787)',
    '+974'  => 'Qatar (+974)',
    '+262'  => 'Réunion (+262)',
    '+40'   => 'Romania (+40)',
    '+7'    => 'Russia (+7)',
    '+250'  => 'Rwanda (+250)',
    '+590'  => 'Saint Barthélemy (+590)',
    '+1‑869' => 'Saint Kitts & Nevis (+1‑869)',
    '+1‑758' => 'Saint Lucia (+1‑758)',
    '+508'  => 'Saint Pierre & Miquelon (+508)',
    '+1‑784' => 'Saint Vincent & the Grenadines (+1‑784)',
    '+685'  => 'Samoa (+685)',
    '+378'  => 'San Marino (+378)',
    '+239'  => 'São Tomé & Príncipe (+239)',
    '+966'  => 'Saudi Arabia (+966)',
    '+221'  => 'Senegal (+221)',
    '+381'  => 'Serbia (+381)',
    '+248'  => 'Seychelles (+248)',
    '+232'  => 'Sierra Leone (+232)',
    '+65'   => 'Singapore (+65)',
    '+1‑721' => 'Sint Maarten (+1‑721)',
    '+421'  => 'Slovakia (+421)',
    '+386'  => 'Slovenia (+386)',
    '+677'  => 'Solomon Islands (+677)',
    '+252'  => 'Somalia (+252)',
    '+27'   => 'South Africa (+27)',
    '+82'   => 'South Korea (+82)',
    '+211'  => 'South Sudan (+211)',
    '+34'   => 'Spain (+34)',
    '+94'   => 'Sri Lanka (+94)',
    '+249'  => 'Sudan (+249)',
    '+597'  => 'Suriname (+597)',
    '+268'  => 'Eswatini (Swaziland) (+268)',
    '+46'   => 'Sweden (+46)',
    '+41'   => 'Switzerland (+41)',
    '+963'  => 'Syria (+963)',
    '+886'  => 'Taiwan (+886)',
    '+992'  => 'Tajikistan (+992)',
    '+255'  => 'Tanzania (+255)',
    '+66'   => 'Thailand (+66)',
    '+670'  => 'Timor‑Leste (+670)',
    '+228'  => 'Togo (+228)',
    '+690'  => 'Tokelau (+690)',
    '+676'  => 'Tonga (+676)',
    '+1‑868' => 'Trinidad & Tobago (+1‑868)',
    '+216'  => 'Tunisia (+216)',
    '+90'   => 'Turkey (+90)',
    '+993'  => 'Turkmenistan (+993)',
    '+1‑649' => 'Turks & Caicos Islands (+1‑649)',
    '+688'  => 'Tuvalu (+688)',
    '+256'  => 'Uganda (+256)',
    '+380'  => 'Ukraine (+380)',
    '+971'  => 'United Arab Emirates (+971)',
    '+44'   => 'United Kingdom (+44)',
    '+1‑340' => 'U.S. Virgin Islands (+1‑340)',
    '+598'  => 'Uruguay (+598)',
    '+998'  => 'Uzbekistan (+998)',
    '+678'  => 'Vanuatu (+678)',
    '+379'  => 'Vatican City (+379)',
    '+58'   => 'Venezuela (+58)',
    '+84'   => 'Vietnam (+84)',
    '+967'  => 'Yemen (+967)',
    '+260'  => 'Zambia (+260)',
    '+263'  => 'Zimbabwe (+263)',
];
return $countryDialCodes;
    }
    public static function getModernizationYears()
{
    $years = [];
    $quarters = [
        ''   => '',           // no quarter
        'Q1' => 'Q1',
        'Q2' => 'Q2',
        'Q3' => 'Q3',
        'Q4' => 'Q4',
    ];

    for ($i = 1950; $i <= date('Y'); $i++) {
        foreach ($quarters as $qKey => $qLabel) {
            if ($qKey) {
                $years[$i . $qKey] = $qLabel . ' ' . $i; // e.g., Q1 2025
            } else {
                $years[$i] = $i; // just year
            }
        }
    }

    return $years;
}
public static function Zimmers(){
    return [1=>1,2=>2,3=>3,4=>4,5=>'5 und mehr'];
}

}
