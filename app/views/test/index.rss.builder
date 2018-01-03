require 'time'
require 'digest/md5'

xml.instruct! :xml, version: "1.0"
xml.rss version: "2.0", :'xmlns:atom' => 'http://www.w3.org/2005/Atom', 
    :'xmlns:itunes' => "http://www.itunes.com/dtds/podcast-1.0.dtd" do
  xml.channel do
    xml.title "hoe"
    xml.description ""
    #xml.tag! 'itunes:summary', 'desc'
    xml.link request.original_url
    xml.tag! 'atom:link', href: request.original_url, rel:"self", type:"application/rss+xml"
    #xml.tag! 'itunes:category', text: 'Arts'
    #xml.tag! 'itunes:author', "author"
    #xml.language "ja"

    @files.files.each do |file|
      # TODO: クエリに_-が入るとiTunesで正常に表示されない
      file_url = "#{request.scheme}://#{request.host_with_port}/test/item.mp3?id=#{file.id}"
      xml.item do
        xml.title file.name
        #xml.description "desc"
        #xml.tag! 'itunes:author', 'author'
        #xml.tag! 'itunes:explicit', 'no'
        #xml.tag! 'itunes:subtitle', 'a'
        #xml.tag! 'itunes:duration', '10:00'
        xml.pubDate file.created_time.rfc2822
        xml.link file.web_view_link
        xml.guid file_url
        xml.enclosure url: file_url  ,type: file.mime_type, length: file.size
      end
    end
  end
end
