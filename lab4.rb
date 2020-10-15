key=gets.split ' '
value=gets.split ' '
x=Hash.new
key.each_with_index {|key,i|x[key]=value[i]}
puts x.to_s