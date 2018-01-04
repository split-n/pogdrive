xml.instruct! :xml, version: "1.0"
xml.rss version: "2.0", :'xmlns:atom' => 'http://www.w3.org/2005/Atom', 
    :'xmlns:itunes' => "http://www.itunes.com/dtds/podcast-1.0.dtd" do
  xml.channel do
    xml.title @podcast.title
    xml.description ""
    xml.link admin_podcast_url(@podcast)
    xml.tag! 'atom:link', href: request.original_url, rel:"self", type:"application/rss+xml"

    @podcast.episodes.get_ordered.each do |ep|
      xml.item do
        file_url = episode_file_url(ep)
        xml.title ep.title
        xml.pubDate ep.gd_created_time.rfc2822
        xml.link ep.gd_web_view_link
        xml.guid file_url
        xml.enclosure url: file_url  ,type: ep.gd_mime_type, length: ep.gd_size
      end
    end
  end
end
