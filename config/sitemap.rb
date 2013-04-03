# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.las7encinas.com/"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
end

# # Set the langage
# FastGettext.set_locale(ENV["LANG"])
# 
# # Set the domain name
# if ENV["LANG"] == 'en'
#   SitemapGenerator::Sitemap.default_host = 'http://www.videoagency.com'
# elsif ENV["LANG"] == 'fr'
#   SitemapGenerator::Sitemap.default_host = 'http://www.videoagency.fr'
# end

# SitemapGenerator::Sitemap.filename = "sitemap_" + ENV["LANG"]
