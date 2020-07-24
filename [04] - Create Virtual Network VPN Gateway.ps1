# connect-AzureRM

$pubIP = New-AzureRmPublicIpAddress -Name 'JMM_VNet01Gateway_PublicIP' -ResourceGroupName JMM_RG01 -Location UKSouth -AllocationMethod Dynamic
$vnet = Get-AzureRmVirtualNetwork -name 'JMM_VNet01' -ResourceGroupName JMM_RG01
$subnet = Get-AzureRmVirtualNetworkSubnetConfig -Name 'GatewaySubnet' -VirtualNetwork $vnet
$pubIPconfig = New-AzureRmVirtualNetworkGatewayIpConfig -Name 'JMM_VNet01Gateway_PublicIP' -SubnetId $subnet.Id -PublicIpAddressId $pubIP.Id
New-AzureRmVirtualNetworkGateway -Name JMM_VNet01Gateway -ResourceGroupName JMM_RG01 -Location UKSouth -IpConfigurations $pubIPconfig -GatewayType Vpn -VpnType RouteBased 
