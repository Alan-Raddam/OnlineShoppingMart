def calcumulti(m)
  answer = 1
  i = m % 10
  m = m / 10
  until m == 0
    if i != 0
      #puts "multi #{i}"
      answer *= i
    end
    i = m % 10
    m = m / 10
  end
  answer *= i unless i == 0
  answer
end

def mfp(m)
  answer = 0
  (1..m).each do |i|
    answer += calcumulti i
  end
  getmaxprime answer
end

def getmaxprime(n)
  if n == 1
    return nil
  end
  while n > 1 do
    (2..n).each do |i|
      if n == i
        return n
      end
      if n % i == 0
        n = n / i
        break
      end
    end
  end
  n
end

