cookbook_path []
cookbook_path << File.expand_path("./automagic-base", __FILE__)
cookbook_path << File.expand_path("../automagic", __FILE__)

log_level :info
