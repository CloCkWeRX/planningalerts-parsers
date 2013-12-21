class FairfieldScraper < Scraper

  def parse_application(table)
    record = {}
    record['council_reference'] = ''
    record['description'] = ''

    table.css("td").each do |cell|
      raise cell.inspect
    #   [
    #     "Council DA No</strong>", 
    #     "File Number</strong>", 
    #     "Application Number</strong>", 
    #     "Council DA No:</strong>", 
    #     "File Number:</strong>", 
    #     "Application Number:</strong>", 
    #     "Council DA No.</strong>", 
    #     "File No.</strong>", 
    #     "Application No.</strong>", 
    #     "Council DA No</strong>", 
    #     "File Number</span>", 
    #     "Application Number</span>", 
    #     "Council DA No:</span>", 
    #     "File Number:</span>", 
    #     "Application Number:</span>", 
    #     "Council DA No.</span>", 
    #     "File No.</span>", 
    #     "Application No.</span>", 
    #     "<strong>Application"
    #   ].each do |token|
    #     if cell.text.match? token
    #       record['council_reference'] = html_entity_decode(cell.next_sibling().plaintext)
    #       record['council_reference'] = preg_replace('/[ ]/', '', record['council_reference'])
    #     end
    #   end

    #   [
    #     "Property Address</strong>",
    #     "Location</strong>",
    #     "Property Address</span>",
    #     "Location</span>",
    #     "Property Address:</strong>",
    #     "Location:</strong>",
    #     "Property Address:</span>",
    #     "Location:</span>"
    #   ].each do |token|
    #     if cell.text.match? token
    #       record['address'] = preg_replace('/[^a-zA-Z0-9 \.,]/', '', html_entity_decode(cell.next_sibling().plaintext)).strip + ", NSW"
    #     end
    #   end

    #   [
    #     "Project Title</strong>",
    #     "Development</strong>",
    #     "Details</strong>",
    #     "Project Title:</strong>",
    #     "Development:</strong>",
    #     "Exhibition:</strong>",
    #     "Project Title</span>",
    #     "Development</span>",
    #     "Details</span>",
    #     "Project Title:</span>",
    #     "Development:</span>",
    #     "Exhibition:</span>"
    #   ].each do |token|
    #     if cell.text.match? token
          
    #       description = html_entity_decode(cell.next_sibling().plaintext).strip
    #       description = preg_replace('/[^a-zA-Z0-9 \.,]/', '', description)
    #       if(strlen(description) > 228)
            
    #         description = substr(description, 0, 225) + "..."
    #       end
            
    #       record['description'] = description
    #     end
    #   end

    #   [
    #     "<strong>Date DA Lodged</strong>",
    #     "Date DA Lodged</span>"
    #   ].each do |token|
    #     if cell.text.match? token
    #       record['date_received'] = date('Y-m-d', strtotime(html_entity_decode(cell.next_sibling().plaintext).strip)))
    #     end
    #   end


    #   ["Exhibition dates</"].each do |token|
    #     if cell.text.match? token
    #       dateString = html_entity_decode(cell.next_sibling().plaintext).strip
    #       dateArray = preg_split('/ to /i', dateString)
    #       date = date('Y-m-d', strtotime(dateArray[1].strip))
    #       if(date != '1970-01-01')
    #         record['on_notice_to'] = date
    #       else
    #           dateArray = preg_split('/ - /i', dateString)
    #           date = date('Y-m-d', strtotime(dateArray[1].strip))
    #           if(date != '1970-01-01')
    #               record['on_notice_to'] = date
    #           end
    #         end
    #       end
    #     end
    #   end



    #   [">Exhibition Period"].each do |token|
    #     if cell.text.match? token    
    #       dateString = html_entity_decode(cell.next_sibling().plaintext).strip
    #       preg_match('/ from (.+) to (.+)\. Copies/i', dateString, dateArray)
    #       date = date('Y-m-d', strtotime(dateArray[2].strip))
    #       if(date != '1970-01-01')
    #         record['on_notice_to'] = date
    #       end
    #     end
    #   end
    end

    record['info_url'] = 'http://www.fairfieldcity.nsw.gov.au/default.asp?iNavCatId=7&iSubCatId=86'
    record['comment_url'] = 'http://www.fairfieldcity.nsw.gov.au/default.asp?iDocID=6779&iNavCatID=54&iSubCatID=2249'

    DevelopmentApplication.new(record)
  end

  def applications(date)
    mainUrl = Net::HTTP.get_response(URI.parse("http://www.fairfieldcity.nsw.gov.au/default.asp?iNavCatId=7&iSubCatId=86")).body

    dom = Nokogiri::HTML(mainUrl)
    container = dom.css("#main table #content").first
    raise container.to_s

    container.xpath("table").collect{|table| parse_application(table) }
  end
end
