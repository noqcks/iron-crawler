require 'mechanize'

# Enables the spidering of websites by utilizing Mechanize
class Crawler < Mechanize

  def initialize
    @mech = Mechanize.new
  end

  # Kicks off the spidering of a site.
  # @param [String] A simple URL string to crawl.
  # @return [Hash] A hash of URls crawled.
  #
  def spiderize(url)
    @mech.max_history = nil
    stack = @mech.get(url).links
    p stack.class
    crawl_loop(stack)
    @mech.history
  end

  # Whether we should reject to spider a URL.
  # @param [Mechanize::Page::Link] A mechanize page link.
  # @return [Boolean] true if we should reject URL.
  #
  def reject(link)
    return true unless link.uri
    host = link.uri.host
    # TODO: are we accounting for subdomains?
    return true unless host.nil? || host == @mech.history.first.uri.host
    begin
      return true if @mech.visited? link.href
    rescue Mechanize::UnsupportedSchemeError
      puts "skipping #{link.uri}"
      return true
    end
    return false
  end

  # The loop we use to spider through all the URLs.
  # @param [Array] An array of Mechanize::Page::Link to crawl.
  # @return [Booolean] true when finished.
  #
  def crawl_loop(stack)
    while link = stack.pop
      next if reject(link)
      puts "crawling #{link.uri}"
      begin
        page = link.click
        next unless Mechanize::Page == page
        stack.push(*page.links)
      rescue Mechanize::ResponseCodeError
      end
    end
    return true
  end

end
