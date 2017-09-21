namespace :cases do
  namespace :new do
    desc 'Import new cases since last run'
    task import: :environment do
      CaseService.new.crawl_new_cases
    end
  end
end
