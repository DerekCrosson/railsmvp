namespace :billing do
  # Run `rake billing:process` if running manually.
  task process: :environment do
    puts "Run nightly billing in this task."
  end
end
