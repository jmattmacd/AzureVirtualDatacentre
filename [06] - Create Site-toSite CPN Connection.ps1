# connect-azurermaccount 
# CHANGE THE PSK!

$gateway = Get-AzureRMVirtualNetworkGateway -Name JMM_VNet01Gateway -ResourceGroupName JMM_RG01
$local = Get-AzureRMLocalNetworkGateway -Name OnPremiseGateway -ResourceGroupName JMM_RG01
New-AzureRMVirtualNetworkGatewayConnection -Name JMM_VNNet01ToONPrem -ResourceGroupName JMM_RG01 -Location UKSouth -VirtualNetworkGateway1 $gateway -LocalNetworkGateway2 $local -ConnectionType IPsec -RoutingWeight 10 -SharedKey 'abc123' 
