xml.instruct! :xml, version: "1.0"
xml.rss version: "2.0", :'xmlns:atom' => 'http://www.w3.org/2005/Atom', 
    :'xmlns:itunes' => "http://www.itunes.com/dtds/podcast-1.0.dtd" do
  xml.channel do
    xml.title @podcast.title
    xml.description ""
    xml.link admin_podcast_url(@podcast)
    xml.tag! 'atom:link', href: request.original_url, rel:"self", type:"application/rss+xml"
  end
end
