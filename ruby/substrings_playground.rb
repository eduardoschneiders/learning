require_relative 'substrings'

dictionary = ['below', 'down', 'go', 'going', 'horn', 'how', 'howdy', 'it', 'i', 'low', 'own', 'part', 'partner', 'sit']
matches = substrings("Howdy below, go eit down! How's it going?", dictionary)

puts matches
