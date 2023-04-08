# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://www.fippo-map.com/"

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
  add root_path, priority: 0.9, changefreq: 'daily'
  add login_path, priority: 0.5, changefreq: 'daily'
  add new_user_path, priority: 0.5, changefreq: 'daily'
  User.find_each do |user|
    add edit_user_path(user), lastmod: user.updated_at
    add user_path(user), lastmod: user.updated_at
  end
  add fishes_path, priority: 1.0, changefreq: 'daily'
  add complete_fishes_path, priority: 0.6, changefreq: 'daily'
  add complete_edit_fishes_path, priority: 0.6, changefreq: 'daily'
  add new_fish_path, priority: 0.8, changefreq: 'daily'
  Fish.find_each do |fish|
    add edit_fish_path(fish), lastmod: fish.updated_at
    add fish_path(fish), lastmod: fish.updated_at
  end
  add complete_fishes_path, priority: 0.6, changefreq: 'daily'
  add complete_edit_fishes_path, priority: 0.6, changefreq: 'daily'
  add new_fish_path, priority: 0.8, changefreq: 'daily'
  add mypage_dashboard_path, priority: 0.7, changefreq: 'daily'
  add mypage_follows_path, priority: 0.7, changefreq: 'daily'
  add mypage_followers_path, priority: 0.7, changefreq: 'daily'
  add mypage_notifications_path, priority: 0.7, changefreq: 'daily'
end
