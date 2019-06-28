require 'digest/md5'

module UpdateChecksum
  puts "Come on"
  class Error < StandardError; end
  # Your code goes here...

  Bundler::Plugin.add_hook('after-install-all') do
    puts 'Gems installed and loaded! Lets update Gemfile.lock hash for CI'

    new_hash = Digest::MD5.hexdigest(File.read('Gemfile.lock'))

    text = File.read('.gitlab-ci.yml')
    new_contents = text.gsub(/GEMFILE_LOCK_HASH: '(.*?)'/, "GEMFILE_LOCK_HASH: '#{new_hash}'")

    # To write changes to the file, use:
    File.open('.gitlab-ci.yml', 'w') {|file| file.puts new_contents }
  end

end