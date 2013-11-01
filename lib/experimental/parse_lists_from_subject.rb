

LISTS = []
LISTS << "CJG"
LISTS << "Kindergruppen"
LISTS << "CJG15"
LISTS << "Messdiener"

def parse_lists_from_subject(subject)
  # extract part between '[...]'
  subject.to_s.match(/\[(.*)\]/)
  if $1
    subject_array = $1.split(/[\s,|]/)
  else
    return []
  end
    
  lists = []
  LISTS.each do |list|
     subject_array.each do |pot_list| 
       if pot_list.casecmp(list) == 0
          lists << list
       end
     end
  end
  return lists
end
  
s = "[CJG15| CJG12, CJG,messdiener] Kindergruppen"
lists = parse_lists_from_subject(s)

lists.each do |l|
  puts l
end
