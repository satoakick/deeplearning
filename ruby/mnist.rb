# [remark] Assume that there is the Leaning data and Test Data files in current dir.

# This is the script which converts 28*28 to 764 dimension vector.
# The more detail format is http://yann.lecun.com/exdb/mnist/.

filename = 'train-images-idx3-ubyte' # Learning data
#filename = 'train-labels-idx1-ubyte' # Test data


count = 1
line = 1
p "file write begin."

File.open("#{filename.split('.')[0]}.txt","w") do |file| # assume that file is in current dir!
  f = open(file_path, "rb")
  f.each_byte do |c|
      byte = "%02X"%c
      file.print("#{byte} ") if count > 784 # skip the first 16bytes(see http://yann.lecun.com/exdb/mnist/)
      if count > 784 && count % 784 == 0 # add the line break
        file.puts ""
        line += 1
        puts "the #{line} -th "
      end
    count += 1
  end
  f.close
end
p "file write end."
