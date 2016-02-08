require 'mechanize'

# Enables the spidering of websites by utilizing Mechanize
class Crawler < Mechanize

  def initialize
    @mech = Mechanize.new
    @mech.max_history = nil
  end


  # Kicks off the spidering of a site.
  # @param [String] A simple URL string to crawl.
  # @return [Hash] A hash of URls crawled.
  #
  def spiderize(url)
    page = @mech.get(url)
    stack = page.links
    stack.push(*src_links(page))

    while link = stack.pop
      next if reject(link)
      puts "crawling #{link.uri}"
      begin
        page = link.click
        next unless Mechanize::Page === page
        stack.push(*src_links(page))
        stack.push(*page.links)
      rescue Mechanize::ResponseCodeError
      end
    end

    @mech.history.inspect
  end


  # Since mechanize doesn't treat src elements as links, this will
  # return all src links from a page.
  # @param [Mechanize::Page] A mechanize page object.
  # @return [Array] An array of created Mechanize::Page::Link objects.
  #
  def src_links(page)
    links = []
    page.search('script').each do |element|
      next if element.attributes['src'].nil?
      doc = Nokogiri::HTML::Document.new
      node = Nokogiri::XML::Node.new('foo', doc)
      node['href'] = element.attributes['src'].value
      link = Mechanize::Page::Link.new(node, @mech, page)
      links.push(link)
    end
    return links
  end


  # Whether we should reject to spider a URL.
  # @param [Mechanize::Page::Link] A mechanize page link.
  # @return [Boolean] true if we should reject URL.
  #
  def reject(link)
    if not_valid_uri?(link) || not_same_domain?(link) || already_spidered?(link)
      return true
    else
      return false
    end
  end


  # Checks whether a link has already been crawled.
  # @param [Mechanize::Page::Link] A mechanize page link.
  # @return [Booolean] true when already spidered.
  #
  def already_spidered?(link)
    abs_url = @mech.history.first.uri.to_s.chomp('/') + link.href + '/'
    return true if (@mech.visited? link.href) || (@mech.visited? abs_url)
  end


  # Checks whether a URL is able to be crawled.
  # @param [Mechanize::Page::Link] A mechanize page link.
  # @return [Booolean] true when valid URL.
  #
  def not_valid_uri?(link)
    if link.uri
      return true unless /^http.+/ =~ link.uri.to_s || /\/.+/ =~ link.uri.to_s
    else
      return true
    end
  end


  # Checks whether a URL is from the same domain.
  # @param [Mechanize::Page::Link] A mechanize page link.
  # @return [Booolean] true when not the same domain as original URL.
  #
  def not_same_domain?(link)
    host = link.uri.host
    return true unless host.nil? || host == @mech.history.first.uri.host
  end

  private :not_valid_uri?, :not_same_domain?, :already_spidered?
end
