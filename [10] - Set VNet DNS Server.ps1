$vnet = Get-AzureRmVirtualNetwork -ResourceGroupName JMM_RG01 -name JMM_VNet01 
$vnet.DhcpOptions.DnsServers = 10.$IP.190.20
Set-AzureRmVirtualNetwork -VirtualNetwork $vnet 
