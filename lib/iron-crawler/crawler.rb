require 'mechanize'

# Enables the spidering of websites by utilizing Mechanize
class Crawler < Mechanize

  def initialize
    @mech = Mechanize.new
  end


  def spiderize url
    @mech.max_history = nil
    stack = @mech.get(url).links
    crawl_loop(stack)
    @mech.history
  end


  def reject(site)
    true unless site.uri
    host = site.uri.host
    # TODO: are we accounting for subdomains?
    true unless host.nil? || host == @mech.history.first.uri.host
    begin
      true if @mech.visited? site.href
    rescue Mechanize::UnsupportedSchemeError
      puts "skipping #{site.uri}"
      true
    end
  end


  def crawl_loop(stack)
     while site = stack.pop
      next if reject(site)
      puts "crawling #{site.uri}"
      begin
        page = site.click
        next unless Mechanize::Page === page
        stack.push(*page.links)
      rescue Mechanize::ResponseCodeError
      end
    end
  end

end
