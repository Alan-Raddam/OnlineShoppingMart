#puts $x
#puts "the length is #{$x.length}"
def check(nowpos)
  if nowpos==$x.size-1
    if $x[nowpos]!='0'
      $ans+=1
    end
    return
  end
  if nowpos==$x.size-2
    if $x[nowpos]=='0'
      return
    end
    check(nowpos+1)  #将这个点解析为单个的字母，继续进行迭代
    if ($x[nowpos..nowpos+1].join.to_i>0)&& ($x[nowpos..nowpos+1].join.to_i<=26)
      $ans+=1
    end
    return
  end
  if $x[nowpos]=='0'
    return
  end
  check nowpos+1
  if ($x[nowpos..nowpos+1].join.to_i>0)&& ($x[nowpos..nowpos+1].join.to_i<=26)
    check nowpos+2
  end
end

$read=gets
while $read.length!=0
  $ans = 0
  $x = $read.split ""
  $x = $x[0...$x.length - 1]
  check 0
  puts $ans
  $read = gets
  break if $read.nil?
end
