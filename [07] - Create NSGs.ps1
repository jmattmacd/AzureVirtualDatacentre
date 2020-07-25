# connect-azurermaccount 

$nsg = New-AzureRmNetworkSecurityGroup -Name ManagementNSG -ResourceGroupName JMM_RG01 -Location UKSouth
$vnet = Get-AzureRmVirtualNetwork -ResourceGroupName JMM_RG01 -Name JMM_VNET01
$subnet = Get-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $vnet -name ManagementSubnet
$subnet.NetworkSecurityGroup = $nsg
Set-AzureRmVirtualNetwork -VirtualNetwork $vnet
$nsg | Add-AzureRmNetworkSecurityRuleConfig -Name AllowLoadBalancer -Description "Allows Azure Probe" -Access Allow -Protocol * -Priority 4095 -SourceAddressPrefix AzureLoadBalancer -SourcePortRange * -DestinationAddressprefix * -DestinationPortRange * -Direction Inbound | Set-AzureRmNetworkSecurityGroup
$nsg | Add-AzureRmNetworkSecurityRuleConfig -Name AllowRDP -Description "Allows RDP from any Subnet" -Access Allow -Protocol TCP -Priority 1024 -SourceAddressPrefix VirtualNetwork -SourcePortRange * -DestinationAddressprefix * -DestinationPortRange 3389 -Direction Inbound | Set-AzureRmNetworkSecurityGroup
$nsg | Add-AzureRmNetworkSecurityRuleConfig -Name Block_VNet1 -Description "Blocks Subnet to Subnet Traffic" -Access Deny -Protocol * -Priority 4096 -SourceAddressPrefix VirtualNetwork -SourcePortRange * -DestinationAddressprefix VirtualNetwork -DestinationPortRange * -Direction Inbound | Set-AzureRmNetworkSecurityGroup

$nsg = New-AzureRmNetworkSecurityGroup -Name WebNSG -ResourceGroupName JMM_RG01 -Location UKSouth
$vnet = Get-AzureRmVirtualNetwork -ResourceGroupName JMM_RG01 -Name JMM_VNET01
$subnet = Get-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $vnet -name WebSubnet
$subnet.NetworkSecurityGroup = $nsg
Set-AzureRmVirtualNetwork -VirtualNetwork $vnet
$nsg | Add-AzureRmNetworkSecurityRuleConfig -Name AllowHTTPS -Description "Allows HTTPS traffic" -Access Allow -Protocol TCP -Priority 1022 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressprefix * -DestinationPortRange 443 -Direction Inbound | Set-AzureRmNetworkSecurityGroup
$nsg | Add-AzureRmNetworkSecurityRuleConfig -Name AllowHTTP -Description "Allows HTTP traffic" -Access Allow -Protocol TCP -Priority 1023 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressprefix * -DestinationPortRange 80 -Direction Inbound | Set-AzureRmNetworkSecurityGroup
$nsg | Add-AzureRmNetworkSecurityRuleConfig -Name AllowLoadBalancer -Description "Allows Azure Probe" -Access Allow -Protocol * -Priority 4095 -SourceAddressPrefix AzureLoadBalancer -SourcePortRange * -DestinationAddressprefix * -DestinationPortRange * -Direction Inbound | Set-AzureRmNetworkSecurityGroup
$nsg | Add-AzureRmNetworkSecurityRuleConfig -Name AllowRDP -Description "Allows RDP from Management Tier" -Access Allow -Protocol TCP -Priority 1024 -SourceAddressPrefix 10.$IP.200.0/24 -SourcePortRange * -DestinationAddressprefix * -DestinationPortRange 3389 -Direction Inbound | Set-AzureRmNetworkSecurityGroup
$nsg | Add-AzureRmNetworkSecurityRuleConfig -Name Block_VNet1 -Description "Blocks Subnet to Subnet Traffic" -Access Deny -Protocol * -Priority 4096 -SourceAddressPrefix VirtualNetwork -SourcePortRange * -DestinationAddressprefix VirtualNetwork -DestinationPortRange * -Direction Inbound | Set-AzureRmNetworkSecurityGroup

$nsg = New-AzureRmNetworkSecurityGroup -Name BusinessNSG -ResourceGroupName JMM_RG01 -Location UKSouth
$vnet = Get-AzureRmVirtualNetwork -ResourceGroupName JMM_RG01 -Name JMM_VNET01
$subnet = Get-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $vnet -name BusinessSubnet
$subnet.NetworkSecurityGroup = $nsg
Set-AzureRmVirtualNetwork -VirtualNetwork $vnet
$nsg | Add-AzureRmNetworkSecurityRuleConfig -Name AllowLoadBalancer -Description "Allows Azure Probe" -Access Allow -Protocol * -Priority 4095 -SourceAddressPrefix AzureLoadBalancer -SourcePortRange * -DestinationAddressprefix * -DestinationPortRange * -Direction Inbound | Set-AzureRmNetworkSecurityGroup
$nsg | Add-AzureRmNetworkSecurityRuleConfig -Name AllowRDP -Description "Allows RDP from Management Tier" -Access Allow -Protocol TCP -Priority 1024 -SourceAddressPrefix 10.$IP.200.0/24 -SourcePortRange * -DestinationAddressprefix * -DestinationPortRange 3389 -Direction Inbound | Set-AzureRmNetworkSecurityGroup
$nsg | Add-AzureRmNetworkSecurityRuleConfig -Name Block_VNet1 -Description "Blocks Subnet to Subnet Traffic" -Access Deny -Protocol * -Priority 4096 -SourceAddressPrefix VirtualNetwork -SourcePortRange * -DestinationAddressprefix VirtualNetwork -DestinationPortRange * -Direction Inbound | Set-AzureRmNetworkSecurityGroup
 
$nsg = New-AzureRmNetworkSecurityGroup -Name DataNSG -ResourceGroupName JMM_RG01 -Location UKSouth
$vnet = Get-AzureRmVirtualNetwork -ResourceGroupName JMM_RG01 -Name JMM_VNET01
$subnet = Get-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $vnet -name DataSubnet
$subnet.NetworkSecurityGroup = $nsg
Set-AzureRmVirtualNetwork -VirtualNetwork $vnet
$nsg | Add-AzureRmNetworkSecurityRuleConfig -Name AllowSQL -Description "Allows SQL from Business Tier" -Access Allow -Protocol TCP -Priority 1023 -SourceAddressPrefix 10.$IP.20.0/24 -SourcePortRange * -DestinationAddressprefix * -DestinationPortRange 1433 -Direction Inbound | Set-AzureRmNetworkSecurityGroup
$nsg | Add-AzureRmNetworkSecurityRuleConfig -Name AllowLoadBalancer -Description "Allows Azure Probe" -Access Allow -Protocol * -Priority 4095 -SourceAddressPrefix AzureLoadBalancer -SourcePortRange * -DestinationAddressprefix * -DestinationPortRange * -Direction Inbound | Set-AzureRmNetworkSecurityGroup
$nsg | Add-AzureRmNetworkSecurityRuleConfig -Name AllowRDP -Description "Allows RDP from Management Tier" -Access Allow -Protocol TCP -Priority 1024 -SourceAddressPrefix 10.$IP.200.0/24 -SourcePortRange * -DestinationAddressprefix * -DestinationPortRange 3389 -Direction Inbound | Set-AzureRmNetworkSecurityGroup
$nsg | Add-AzureRmNetworkSecurityRuleConfig -Name Block_VNet1 -Description "Blocks Subnet to Subnet Traffic" -Access Deny -Protocol * -Priority 4096 -SourceAddressPrefix VirtualNetwork -SourcePortRange * -DestinationAddressprefix VirtualNetwork -DestinationPortRange * -Direction Inbound | Set-AzureRmNetworkSecurityGroup

$nsg = New-AzureRmNetworkSecurityGroup -Name MigrationNSG -ResourceGroupName JMM_RG01 -Location UKSouth
$vnet = Get-AzureRmVirtualNetwork -ResourceGroupName JMM_RG01 -Name JMM_VNET01
$subnet = Get-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $vnet -name MigrationSubnet
$subnet.NetworkSecurityGroup = $nsg
Set-AzureRmVirtualNetwork -VirtualNetwork $vnet 

$nsg = New-AzureRmNetworkSecurityGroup -Name InfrastructureNSG -ResourceGroupName JMM_RG01 -Location UKSouth
$vnet = Get-AzureRmVirtualNetwork -ResourceGroupName JMM_RG01 -Name JMM_VNET01
$subnet = Get-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $vnet -name InfrastructureSubnet
$subnet.NetworkSecurityGroup = $nsg
Set-AzureRmVirtualNetwork -VirtualNetwork $vnet
$nsg | Add-AzureRmNetworkSecurityRuleConfig -Name AllowRPC -Description "Allows RPC Endpoint mapper" -Access Allow -Protocol * -Priority 1023 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressprefix * -DestinationPortRange 135 -Direction Inbound | Set-AzureRmNetworkSecurityGroup
$nsg | Add-AzureRmNetworkSecurityRuleConfig -Name AllowLDAP -Description "Allows LDAP" -Access Allow -Protocol * -Priority 1022 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressprefix * -DestinationPortRange 389 -Direction Inbound | Set-AzureRmNetworkSecurityGroup
$nsg | Add-AzureRmNetworkSecurityRuleConfig -Name AllowLDAPSSL -Description "Allows LDAP SSL" -Access Allow -Protocol TCP -Priority 1021 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressprefix * -DestinationPortRange 636 -Direction Inbound | Set-AzureRmNetworkSecurityGroup
$nsg | Add-AzureRmNetworkSecurityRuleConfig -Name AllowLDAPGC -Description "Allows LDAP GC" -Access Allow -Protocol TCP -Priority 1020 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressprefix * -DestinationPortRange 3268 -Direction Inbound | Set-AzureRmNetworkSecurityGroup
$nsg | Add-AzureRmNetworkSecurityRuleConfig -Name AllowLDAPGCSSL -Description "Allows LDAP GC SSL" -Access Allow -Protocol TCP -Priority 1019 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressprefix * -DestinationPortRange 3269 -Direction Inbound | Set-AzureRmNetworkSecurityGroup
$nsg | Add-AzureRmNetworkSecurityRuleConfig -Name AllowKerb -Description "Allows Kerberos" -Access Allow -Protocol * -Priority 1018 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressprefix * -DestinationPortRange 88 -Direction Inbound | Set-AzureRmNetworkSecurityGroup
$nsg | Add-AzureRmNetworkSecurityRuleConfig -Name AllowDNS -Description "Allows DNS" -Access Allow -Protocol * -Priority 1017 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressprefix * -DestinationPortRange 53 -Direction Inbound | Set-AzureRmNetworkSecurityGroup
$nsg | Add-AzureRmNetworkSecurityRuleConfig -Name AllowSMB -Description "Allows SMB" -Access Allow -Protocol * -Priority 1016 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressprefix * -DestinationPortRange 445 -Direction Inbound | Set-AzureRmNetworkSecurityGroup
$nsg | Add-AzureRmNetworkSecurityRuleConfig -Name AllowDFSR -Description "Allows DFSR SYSVOL" -Access Allow -Protocol TCP -Priority 1015 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressprefix * -DestinationPortRange 5722 -Direction Inbound | Set-AzureRmNetworkSecurityGroup
$nsg | Add-AzureRmNetworkSecurityRuleConfig -Name AllowWTIME -Description "Allows WIN TIME" -Access Allow -Protocol UDP -Priority 1014 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressprefix * -DestinationPortRange 123 -Direction Inbound | Set-AzureRmNetworkSecurityGroup
$nsg | Add-AzureRmNetworkSecurityRuleConfig -Name AllowKerbPW -Description "Allows Kerberos PW" -Access Allow -Protocol * -Priority 1013 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressprefix * -DestinationPortRange 464 -Direction Inbound | Set-AzureRmNetworkSecurityGroup
$nsg | Add-AzureRmNetworkSecurityRuleConfig -Name AllowDFSGP -Description "Allows DFS GP" -Access Allow -Protocol UDP -Priority 1012 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressprefix * -DestinationPortRange 138 -Direction Inbound | Set-AzureRmNetworkSecurityGroup
$nsg | Add-AzureRmNetworkSecurityRuleConfig -Name AllowNETLOGONUDP -Description "Allows NETLOGON UDP" -Access Allow -Protocol UDP -Priority 1010 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressprefix * -DestinationPortRange 137 -Direction Inbound | Set-AzureRmNetworkSecurityGroup
$nsg | Add-AzureRmNetworkSecurityRuleConfig -Name AllowNETLOGONTCP -Description "Allows NETLOGON TCP" -Access Allow -Protocol TCP -Priority 1009 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressprefix * -DestinationPortRange 139 -Direction Inbound | Set-AzureRmNetworkSecurityGroup
$nsg | Add-AzureRmNetworkSecurityRuleConfig -Name AllowLoadBalancer -Description "Allows Azure Probe" -Access Allow -Protocol * -Priority 4095 -SourceAddressPrefix AzureLoadBalancer -SourcePortRange * -DestinationAddressprefix * -DestinationPortRange * -Direction Inbound | Set-AzureRmNetworkSecurityGroup
$nsg | Add-AzureRmNetworkSecurityRuleConfig -Name AllowRDP -Description "Allows RDP from Management Tier" -Access Allow -Protocol TCP -Priority 1024 -SourceAddressPrefix 10.$IP.200.0/24 -SourcePortRange * -DestinationAddressprefix * -DestinationPortRange 3389 -Direction Inbound | Set-AzureRmNetworkSecurityGroup
$nsg | Add-AzureRmNetworkSecurityRuleConfig -Name Block_VNet1 -Description "Blocks Subnet to Subnet Traffic" -Access Deny -Protocol * -Priority 4096 -SourceAddressPrefix VirtualNetwork -SourcePortRange * -DestinationAddressprefix VirtualNetwork -DestinationPortRange * -Direction Inbound | Set-AzureRmNetworkSecurityGroup

$nsg = New-AzureRmNetworkSecurityGroup -Name DMZNSG -ResourceGroupName JMM_RG01 -Location UKSouth
$vnet = Get-AzureRmVirtualNetwork -ResourceGroupName JMM_RG01 -Name JMM_VNET01
$subnet = Get-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $vnet -name DMZSubnet
$subnet.NetworkSecurityGroup = $nsg
Set-AzureRmVirtualNetwork -VirtualNetwork $vnet 
