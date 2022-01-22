EXEC_PATH = "#{Pathname.new(__dir__).to_s}/../../exe/dartsass"

def dartsass_build_mapping
  Rails.application.config.dartsass.stylesheets.map { |input, output| 
    "#{Rails.root.join("app/assets/stylesheets", input)}:#{Rails.root.join("app/assets/builds", output)}"
  }.join(" ")
end

def dartsass_compile_command
   "#{EXEC_PATH} #{dartsass_build_mapping}"
end

namespace :dartsass do
  desc "Build your Dart Sass CSS"
  task build: :environment do
    system dartsass_compile_command
  end

  desc "Watch and build your Dart Sass CSS on file changes"
  task watch: :environment do
    system "#{dartsass_compile_command} -w"
  end
end

Rake::Task["assets:precompile"].enhance(["dartsass:build"])

if Rake::Task.task_defined?("test:prepare")
  Rake::Task["test:prepare"].enhance(["dartsass:build"])
elsif Rake::Task.task_defined?("db:test:prepare")
  Rake::Task["db:test:prepare"].enhance(["dartsass:build"])
end
