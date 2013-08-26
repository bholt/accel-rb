
def find_up_path(filename)
  fs = []
  p = Dir.pwd
  while p.length > 0 do
    if Dir.entries(p).include?(filename) then 
      fs << p+'/'+filename
    end
   i = p.rindex('/')
    if i == 0 then
      p = ""
    else
      p = p[0..i-1]
    end
  end
  return fs
end

