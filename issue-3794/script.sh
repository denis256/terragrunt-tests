#!/bin/bash


echo "Error: creating Route in Route Table (rtb-037af000c0add21c4) with destination (10.0.0.0/8): operation error EC2: CreateRoute, https response error StatusCode: 400, RequestID: df928005-0654-0000-0000-301551a785b3, api error InvalidTransitGatewayID.NotFound: The transitGateway ID 'tgw-xxxxxxxxxxxxxx' does not exist."
exit 1
