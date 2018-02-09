# use 'xsel' or 'xclip' if you're in a Linux environment 
def _cp(kopimi = Readline::HISTORY.entries[-2], options = {})
  if kopimi.respond_to?(:join) && !options[:to_a]
    kopimi = kopimi.map{|i| ":#{i.to_s}" } if options.delete(:to_sym)
    delicious = kopimi.join(", ")
  elsif kopimi.respond_to?(:inspect)
    delicious = kopimi.is_a?(String) ? kopimi : kopimi.inspect
  else
    puts "Sorry, can't print that"
    false
  end
  IO.popen('pbcopy', 'w') { |io| io.write(delicious) }
end
