# connect-azurermaccount
# change the admin account details!

$VMName = "AZHOP01"
$VMSize = "Standard_D2_V2"
$MachineUserName = "JMMAdmin"
$MachinePassword = "JMMSecurePassword!"
$MachineSecurePassword = ConvertTo-SecureString $MachinePassword -AsPlainText -Force
$MachineCredential = New-Object System.Management.Automation.PSCredential ($MachineUserName, $MachineSecurePassword);
$IPconfig = New-AzureRmNetworkInterfaceIpConfig -Name "IPConfig1" -PrivateIpAddressVersion IPv4 -PrivateIpAddress "10.$IP.200.4" -Subnet (Get-AzureRmVirtualNetworkSubnetConfig -name ManagementSubnet -VirtualNetwork (Get-AzureRmVirtualNetwork -name JMM_VNet01 -ResourceGroupName JMM_RG01))
$NICName = $VMName+'_NIC01'
$NICObj = New-AzureRmNetworkInterface -Name $NICName -ResourceGroupName JMM_RG01 -Location UKSouth  -IpConfiguration $IPconfig  -WarningAction SilentlyContinue
$VirtualMachine = New-AzureRmVMConfig -VMName $VMName -VMSize $VMSize
$VirtualMachine = Set-AzureRmVMOperatingSystem -VM $VirtualMachine -Windows -ComputerName $VMName -Credential $MachineCredential -ProvisionVMAgent -EnableAutoUpdate
$VirtualMachine = Add-AzureRmVMNetworkInterface -VM $VirtualMachine -Id $NICObj.Id
$VirtualMachine = Set-AzureRmVMSourceImage -VM $VirtualMachine -PublisherName 'MicrosoftWindowsServer' -Offer 'WindowsServer' -Skus '2016-Datacenter' -Version latest
$VirtualMachineObj = New-AzureRmVM -ResourceGroupName JMM_RG01 -Location UKSouth -VM $VirtualMachine -WarningAction SilentlyContinue 
