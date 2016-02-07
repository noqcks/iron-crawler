require 'mechanize'

class Crawler < Mechanize

  def initialize
    @mech = Mechanize.new
  end

  def spiderize url

    @mech.max_history = nil
    stack = @mech.get(url).links

    while site = stack.pop
      # make sure we really have a uri
      next unless site.uri
      host = site.uri.host

      # skip unless host is relative or host is original domain
      # TODO: are we accounting for subdomains?
      next unless host.nil? or host == @mech.history.first.uri.host

      # skip if we already visited the site
      begin
        next if @mech.visited? site.href
      rescue Mechanize::UnsupportedSchemeError
        puts "skipping #{site.uri}"
        next
      end

      # crawl the URL
      puts "crawling #{site.uri}"
      begin
        page = site.click
        next unless Mechanize::Page === page
        stack.push(*page.links)
      rescue Mechanize::ResponseCodeError
      end
    end

    return @mech.history
  end
end

