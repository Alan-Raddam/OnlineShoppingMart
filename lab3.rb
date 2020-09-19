#puts $x
#puts "the length is #{$x.length}"
def check(input)
  if input.size==0 || input[0]=='0'  #一定不能进行任何匹配
    $ans=0
    return
  end
  dpans=Array.new(input.size+1,0)
  dpans[0]=1   #匹配i[0]
  dpans[1]=1
  (1..input.size-1).each do |i|   #从i[1]开始判断
    if input[i].to_i >=1 && input[i].to_i <=9
      dpans[i+1]+=dpans[i]
    end
    if (input[i-1..i].join.to_i) >0 && (input[i-1..i].join.to_i) <=26 && input[i-1]!='0'
      dpans[i+1]+=dpans[i-1]
    end
  end
  $ans=dpans[input.size]
end

$read=gets
while $read.length!=0
  $ans = 0
  $x = $read.split ""
  $x = $x[0...$x.length - 1]
  check $x
  puts $ans
  $read = gets
  break if $read.nil?
end
