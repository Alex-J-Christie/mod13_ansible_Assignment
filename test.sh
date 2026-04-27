#!/bin/bash
# Pass your VM's IP as an argument when running this script
IP=$1
get_response=$(curl -s -o /dev/null -w "%{http_code}" http://$IP:3000/orders)

if [ "$get_response" == "200" ]; then
  echo "Get Response is running successfully ✔!"
else
  echo "Application failed to start! HTTP Status: $get_response"
fi

full_response=$(curl -s -w "\n%{http_code}" -X POST http://$IP:3000/orders \
  -H "Content-Type: application/json" \
  -d '{
   "orderPrice": 51.29,
   "orderStatus": "PENDING",
   "orderDate": "2026-12-13",
   "customerAcct": "908371"
}')

post_status=$(echo "$full_response" | tail -n1)

post_body=$(echo "$full_response" | sed '$d')

ORDER_ID=$(echo "$post_body" | grep -o -i '"orderId"[[:space:]]*:[[:space:]]*[0-9]*' | grep -o '[0-9]*$')

if [ "$post_status" == "201" ] || [ "$post_status" == "200" ]; then
  echo "Post Response is running successfully ✔! Order ID: $ORDER_ID"
else
  echo "Application failed to start! HTTP Status: $post_status"
fi

delete_response=$(curl -s -o /dev/null -w "%{http_code}" -X DELETE http://$IP:3000/orders/$ORDER_ID)

if  [ "$delete_response" == "204" ] || [ "$delete_response" == "200" ]; then
  echo "Post Response is running successfully ✔!"
else
  echo "Application failed to start! HTTP Status: $delete_response"
fi
