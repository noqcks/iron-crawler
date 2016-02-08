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
    while link = stack.pop
      next if reject(link)
      puts "crawling #{link.uri}"
      begin
        page = link.click
        next unless Mechanize::Page === page
        stack.push(*page.links)
      rescue Mechanize::ResponseCodeError
      end
    end
    return @mech.history
  end


  # Whether we should reject to spider a URL.
  # @param [Mechanize::Page::Link] A mechanize page link.
  # @return [Boolean] true if we should reject URL.
  #
  def reject(link)
    # TODO: are we accounting for subdomains?
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
    begin
      abs_url = @mech.history.first.uri.to_s.chomp('/') + link.href + '/'
      return true if @mech.visited? link.href
      return true if @mech.visited? abs_url
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
    return true unless link.uri && (/^http.+/ =~ link.uri.to_s || /\/.+/ =~ link.uri.to_s)
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
