namespace :feeder do
  desc 'Load test data for each feed'
  task load_test_data: :environment do
    Const::Feeds::URLS.each do |name, url|
      path = "test/data/feed_#{name}.xml"
      File.open(path, 'wt') do |f|
        puts "Saving #{url}\nto #{path}\n\n"
        f.write RestClient.get(url)
      end
    end
  end
end
