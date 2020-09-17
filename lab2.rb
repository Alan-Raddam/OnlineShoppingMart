ans=0
((gets.to_i 10).to_s 2).chars.each do |i|
  if i=='1'
    ans+=1
  end
end
puts ans


