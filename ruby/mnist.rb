file_path = '/Users/sawadasatoaki/Downloads/train-images-idx3-ubyte'
#file_path = '/Users/sawadasatoaki/Downloads/train-labels-idx1-ubyte'

count = 1
line = 1
p "file write begin."
File.open("train-images-idx3-ubyte.txt","w") do |file|
  f = open(file_path, "rb")
  f.each_byte do |c|
      byte = "%02X"%c
      file.print("#{byte} ") if count > 784 # 最初の16バイトはノーカン(see http://yann.lecun.com/exdb/mnist/)
      if count > 784 && count % 784 == 0 # 改行追加
        file.puts ""
        line += 1
        puts "#{line}行目"
      end
    count += 1
  end
  f.close
end
p "file write end."
