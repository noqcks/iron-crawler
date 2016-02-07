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
    crawl_loop(stack)
    @mech.history
  end


  # Whether we should reject to spider a URL.
  # @param [Mechanize::Page::Link] A mechanize page link.
  # @return [Boolean] true if we should reject URL.
  #
  def reject(link)
    # TODO: are we accounting for subdomains?
    if not_same_domain?(link) || not_valid_uri?(link) || already_spidered?(link)
      return true
    else
      return false
    end
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


  # Checks whether a link has already been crawled.
  # @param [Mechanize::Page::Link] A mechanize page link.
  # @return [Booolean] true when already spidered.
  #
  def already_spidered?(link)
    begin
      return true if @mech.visited? link.href
    rescue Mechanize::UnsupportedSchemeError
      puts "skipping #{link.uri}"
      return true
    end
  end


  # Checks whether a URL is able to be crawled.
  # @param [Mechanize::Page::Link] A mechanize page link.
  # @return [Booolean] true when valid URL.
  #
  def not_valid_uri?(link)
    return true unless link.uri
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
