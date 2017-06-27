if File.directory?('.git')
  $g = Git.open('.')
end
