$:.unshift "#{File.dirname(__FILE__)}/lib"
require 'scraper'

Dir.glob("#{File.dirname(__FILE__)}/scrapers/*_scraper.rb").each do |file|
  require file
end

# Require the generic scrapers.
# TODO: Should really move these together with all the other scrapers
require 'spear_scraper'
require 'cgi_scraper'

module Scrapers
  # Central registry of scrapers

  # Council provided XML feeds, listed here for completeness:
  # City of Salisbury: http://www.salisbury.sa.gov.au/feed.rss?listID=53
  # Sutherland Shire Council: http://feeds.ssc.nsw.gov.au/?page=PlanningAlerts&Day=1&Month=11&Year=2011
  # Launceston City Council, TAS: http://api.launceston.tas.gov.au/planning/planningAlerts.ashx

  def self.scrapers
    [BrisbaneScraper.new("Brisbane City Council", "Brisbane", "QLD"),

      #EProclaim
      # Used by https://eservices.holdfast.sa.gov.au/eproclaim/?request_url=ptgeApplications/ptgePlanningRegister.asp (Different version)
      # http://www.marrickville.nsw.gov.au/p190800/eproclaim/ - disabled?
      # https://epeninsula.mornpen.vic.gov.au/p190700/eproclaim/ invalid version?
      # https://eproclaim.stonnington.vic.gov.au/P190901/eproclaim/ Module disabled?
      # https://ecerts.ssc.nsw.gov.au/eproclaim/ DB connection errors?
      # http://eproclaim.wyndham.vic.gov.au/ Errors encountered
      EProclaimScraper.new(
        "Charles Sturt City Council",
        "Charles Sturt",
        "SA",
        "https://ipa.charlessturt.sa.gov.au/eproclaim/",
        "http://www.charlessturt.sa.gov.au/webdata/resources/files/Application_Form_5_-_Statement_of_Representation_Form.pdf"
      ),
      # Disabled until a single DA can be found on their site for testing
      #EProclaimScraper.new("Barossa Council", "Barossa", "SA", "https://eproclaim.barossa.sa.gov.au/p190900/eproclaim/"),
      # TODO: Figure out which of these authorities using the SPEAR system have planning information
      # in the system and which just have subdivision information
      SPEARScraper.new("Ararat Rural City Council (SPEAR)", "Ararat", "VIC", "Ararat Rural City Council"),
      SPEARScraper.new("Ballarat City Council (SPEAR)", "Ballarat", "VIC", "Ballarat City Council"),
      SPEARScraper.new("Banyule City Council (SPEAR)", "Banyule", "VIC", "Banyule City Council"),
      # There are two websites that we're getting data for Boroondara City Council from.
      # Using "Boroondara (City)" to disambiguate from the "Boroondara" used by the SPEAR scraper.
      SPEARScraper.new("Boroondara City Council (SPEAR)", "Boroondara", "VIC", "Boroondara City Council"),
      BoroondaraScraper.new("Boroondara City Council", "Boroondara (City)", "VIC"),
      SPEARScraper.new("Brimbank City Council (SPEAR)", "Brimbank", "VIC", "Brimbank City Council"),
      SPEARScraper.new("Cardinia Shire Council (SPEAR)", "Cardinia", "VIC", "Cardinia Shire Council"),
      SPEARScraper.new("Casey City Council (SPEAR)", "Casey", "VIC", "Casey City Council"),
      SPEARScraper.new("Central Goldfields Shire Council (SPEAR)", "Central Goldfields", "VIC", "Central Goldfields Shire Council"),
      SPEARScraper.new("City of Greater Dandenong (SPEAR)", "Dandenong", "VIC", "City of Greater Dandenong"),
      SPEARScraper.new("City of Greater Geelong (SPEAR)", "Geelong", "VIC", "City of Greater Geelong"),
      SPEARScraper.new("Darebin City Council (SPEAR)", "Darebin", "VIC", "Darebin City Council"),
      SPEARScraper.new("Frankston City Council (SPEAR)", "Frankston", "VIC", "Frankston City Council"),
      SPEARScraper.new("Gannawarra Shire Council (SPEAR)", "Gannawarra", "VIC", "Gannawarra Shire Council"),
      SPEARScraper.new("Glenelg Shire Council (SPEAR)", "Glenelg", "VIC", "Glenelg Shire Council"),
      SPEARScraper.new("Golden Plains Shire Council (SPEAR)", "Golden Plains", "VIC", "Golden Plains Shire Council"),
      SPEARScraper.new("Greater Shepparton City Council (SPEAR)", "Shepparton", "VIC", "Greater Shepparton City Council"),
      SPEARScraper.new("Hepburn Shire Council (SPEAR)", "Hepburn", "VIC", "Hepburn Shire Council"),
      SPEARScraper.new("Hobsons Bay City Council (SPEAR)", "Hobsons Bay", "VIC", "Hobsons Bay City Council"),
      SPEARScraper.new("Manningham City Council (SPEAR)", "Manningham", "VIC", "Manningham City Council"),
      SPEARScraper.new("Maroondah City Council (SPEAR)", "Maroondah", "VIC", "Maroondah City Council"),
      # This one is a little strange. Need to see what we can sensibly call it
      SPEARScraper.new("Minister for Planning - Others (SPEAR)", "Victoria", "VIC", "Minister for Planning - Others"),
      SPEARScraper.new("Minister for Planning - Social Housing (SPEAR)", "Victoria (Social Housing)", "VIC", "Minister for Planning - Social Housing"),
      SPEARScraper.new("Mitchell Shire Council (SPEAR)", "Mitchell", "VIC", "Mitchell Shire Council"),
      SPEARScraper.new("Moonee Valley City Council (SPEAR)", "Moonee Valley", "VIC", "Moonee Valley City Council"),
      SPEARScraper.new("Moreland City Council (SPEAR)", "Moreland", "VIC", "Moreland City Council"),
      SPEARScraper.new("Moyne Shire Council (SPEAR)", "Moyne", "VIC", "Moyne Shire Council"),
      SPEARScraper.new("Port Phillip City Council (SPEAR)", "Port Phillip", "VIC", "Port Phillip City Council"),
      SPEARScraper.new("Pyrenees Shire Council (SPEAR)", "Pyrenees", "VIC", "Pyrenees Shire Council"),
      SPEARScraper.new("Shire of Melton (SPEAR)", "Melton", "VIC", "Shire of Melton"),
      SPEARScraper.new("Southern Grampians Shire Council (SPEAR)", "Southern Grampians", "VIC", "Southern Grampians Shire Council"),
      SPEARScraper.new("Surf Coast Shire Council (SPEAR)", "Surf Coast", "VIC", "Surf Coast Shire Council"),
      SPEARScraper.new("Warrnambool City Council (SPEAR)", "Warrnambool", "VIC", "Warrnambool City Council"),
      SPEARScraper.new("Wellington Shire Council (SPEAR)", "Wellington", "VIC", "Wellington Shire Council"),
      SPEARScraper.new("Whittlesea City Council (SPEAR)", "Whittlesea", "VIC", "Whittlesea City Council"),
      SPEARScraper.new("Wyndham City Council (SPEAR)", "Wyndham", "VIC", "Wyndham City Council"),
      SPEARScraper.new("Yarra City Council (SPEAR)", "Yarra", "VIC", "Yarra City Council"),
      SPEARScraper.new("Alpine Shire Council (SPEAR)", "Alpine", "VIC", "Alpine Shire Council"),
      SPEARScraper.new("Bayside City Council (SPEAR)", "Bayside", "VIC", "Bayside City Council"),
      SPEARScraper.new("Benalla Rural City Council (SPEAR)", "Benalla", "VIC", "Benalla Rural City Council"),
      SPEARScraper.new("Greater Bendigo City Council (SPEAR)", "Bendigo", "VIC", "Greater Bendigo City Council"),
      SPEARScraper.new("Hume City Council (SPEAR)", "Hume", "VIC", "Hume City Council"),
      SPEARScraper.new("Maribyrnong City Council (SPEAR)", "Maribyrnong", "VIC", "Maribyrnong City Council"),
      SPEARScraper.new("Rural City of Wangaratta (SPEAR)", "Wangaratta", "VIC", "Rural City of Wangaratta"),
      SPEARScraper.new("Shire of Campaspe (SPEAR)", "Campaspe", "VIC", "Shire of Campaspe"),
      SPEARScraper.new("Stonnington City Council (SPEAR)", "Stonnington (SPEAR)", "VIC", "Stonnington City Council"),
      SydneyScraper.new("City of Sydney", "Sydney", "NSW"),
      LoganScraper.new("Logan City Council", "Logan", "QLD"),
      ACTScraper.new("ACT Planning & Land Authority", "ACT", "ACT"),
      MosmanScraper.new("Mosman Municipal Council", "Mosman", "NSW"),
      # There are two websites that we're getting data for Melbourne City Council from.
      # Using "Melbourne (City)" to disambiguate from the "Melbourne" used by the SPEAR scraper.
      SPEARScraper.new("Melbourne City Council (SPEAR)", "Melbourne", "VIC", "Melbourne City Council"),
      WollongongScraper.new("Wollongong City Council", "Wollongong", "NSW"),
      CGIScraper.new("Department of Planning and Local Government", "EDALA", "SA", "php-cgi -d short_open_tag=0 -d cgi.force_redirect=0 -f", "edala.php"),
      KogarahScraper.new("Kogarah City Council", "Kogarah", "NSW"),
      LakeMacquarieScraper.new("Lake Macquarie City Council", "Lake Macquarie", "NSW"),
      KuringgaiScraper.new("Ku-ring-gai Council", "Ku-ring-gai", "NSW"),
      AlburyScraper.new("Albury City Council", "Albury", "NSW"),
      WarringahScraper.new("Warringah Council", "Warringah", "NSW"),
      WaggaWaggaScraper.new("City of Wagga Wagga", "Wagga Wagga", "NSW"),
      GriffithScraper.new("Griffith City Council", "Griffith", "NSW"),
      WyongScraper.new("Wyong Shire Council", "Wyong", "NSW"),
      HawkesburyScraper.new("Hawkesbury City Council", "Hawkesbury", "NSW"),
      HornsbyScraper.new("Hornsby Shire Council", "Hornsby", "NSW"),
      FraserCoastScraper.new("Fraser Coast Regional Council", "Fraser Coast", "QLD"),
      IpswichScraper.new("City of Ipswich", "Ipswich", "QLD"),
      LockyerValleyScraper.new("Lockyer Valley Regional Council", "Lockyer Valley", "QLD"),
      ToowoombaScraper.new("Toowoomba Regional Council", "Toowoomba", "QLD"),
      RedlandScraper.new("Redland City Council", "Redland", "QLD"),
      CoffsHarbourScraper.new("Coffs Harbour City Council", "Coffs Harbour", "NSW"),
      CGIScraper.new("Moreland City Council", "Moreland (City)", "VIC", "perl", "moreland.pl"),
    ]
  end
  
  def self.scraper_factory(name)
    scrapers.find{|p| p.planning_authority_short_name_encoded == name}
  end
end
