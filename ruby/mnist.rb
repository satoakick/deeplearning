# [Remark] Assume that there is the Leaning data and Test Data files in current dir.
# This is the script which converts 28*28 to 764 dimension vector.
# About the more detail format, see http://yann.lecun.com/exdb/mnist/.

def parse_training_data(input_filename, offset, byte_num_by_a_line)
  count_by_a_byte = 1
  count_by_a_line = 1
  p "file write begin."
  p "parse the image training data: #{input_filename}"
  File.open("#{input_filename}.txt","w") do |file| # assume that original file is in current dir!
    f = IO.binread(input_filename, nil, offset) # skip #{offset}bytes!
    f.each_byte do |c|
      file.print("#{'%02X'%c}")
      file.print(" ") if count_by_a_byte % byte_num_by_a_line != 0
      if count_by_a_byte % byte_num_by_a_line == 0 # add the line break
        file.puts ""
        p "#{count_by_a_line}-th"
        count_by_a_line += 1
      end
      count_by_a_byte += 1
    end
  end
  p "file write end."
end

if ARGV[0] && ARGV[1]
  # Input data
  input_file_name_training_set_image = ARGV[0] # Training data of image
  input_file_name_training_set_label = ARGV[1] # Training data of label

  # parse
  parse_training_data(input_file_name_training_set_image, 16, 784)
  parse_training_data(input_file_name_training_set_label, 8, 1)
else
  p 'first arg is Training data of image'
  p 'second arg is Training data of label'
end
