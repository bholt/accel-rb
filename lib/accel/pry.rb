require 'pry'

def scratch
  FileUtils.mkdir_p(File.expand_path "~/.pry")
  sf = File.expand_path "~/.pry/scratch#{Dir.pwd.gsub(/\//,'#')}.rb"
  # open(sf,"w"){|f| f.write("Igor do\n  \nend\n")} unless File.exists? sf
  Pry::Editor.invoke_editor(sf,2)
  eval(open(sf).read)
end
