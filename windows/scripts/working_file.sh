#parse audit log JSON file

cat audit-20150708-125505.log | grep "ItemFinished" | grep "\"error\":null" | grep "\"action\":\"delete\"" | jq '.data | {action, item}'

#parse audit json file and spit out tabbed list
cat audit-20150708-125505.log | grep "ItemFinished" | grep "\"error\":null" | grep -v "\"action\":\"delete\"" | grep \"type\":\"file\" | jq -r ' [.time[0:10],.time[11:19],.data.type, .data.item] | join("\t")'

test
test2
test3
test4!!!!
test5!!
test6!
test7!
test
test8!