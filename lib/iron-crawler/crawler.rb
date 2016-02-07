require 'mechanize'

class Crawler < Mechanize

  def initialize
    @mech = Mechanize.new
  end

  def self.spiderize(url)
    @mech.max_history = nil
    stack = @mech.get(url).links

    while site = stack.pop
      # make sure we really have a uri
      next unless site.uri
      host = site.uri.host

      # skip unless host is relative or host is original domain
      # TODO: are we accounting for subdomains?
      next unless host.nil? or host == agent.history.first.uri.host

      # skip if we already visited the site
      begin
        next if agent.visited? site.href
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

    return agent.history
  end
end

# # TODO:
# # - concurrent
# # - no # hrefs
# # - link graph using neo4j

# while site = stack.pop
#   # make sure we really have a uri
#   next unless site.uri
#   host = site.uri.host

#   # skip unless host is relative or host is original domain
#   # TODO: are we accounting for subdomains?
#   next unless host.nil? or host == agent.history.first.uri.host

#   # skip if we already visited the site
#   begin
#     next if agent.visited? site.href
#   rescue Mechanize::UnsupportedSchemeError
#     puts "skipping #{site.uri}"
#     next
#   end

#   # crawl the URL
#   puts "crawling #{site.uri}"
#   begin
#     page = site.click
#     next unless Mechanize::Page === page
#     stack.push(*page.links)
#   rescue Mechanize::ResponseCodeError
#   end
# end

# p agent.history
