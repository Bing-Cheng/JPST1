block_date = {'12-02-10','12-03-10','12-06-10','12-07-10','12-09-10'};
block_ch = {'9','10','14'};
block_ids = {[2],[3],[2];[2],[2],[4];[1],[3],[1];[1 3 4],[1 4],[4];[3],[1 4],[1 4]};

for id = 1 : length(block_date)
for ic = 1 : length(block_ch)
  date =  block_date{id};
  ch = block_ch{ic};
  ids = block_ids{id,ic};
  re = 0;
 re = cb_function_combine_template_sorting(date,ch,ids);
end
end