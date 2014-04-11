require 'fileutils'
 
# force the whole app to use its own tmpdir
FileUtils.mkdir_p(Rails.root.join('tmp/files'))
ENV['TMPDIR'] = File.join(Rails.root, 'tmp/files')