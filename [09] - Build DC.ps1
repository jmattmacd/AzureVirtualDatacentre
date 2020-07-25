# connect-azurermaccount
# change the admin account details!

$VMName = "AZDC01"
$VMSize = "Standard_D2_V2"
$MachineUserName = "JMMAdmin"
$MachinePassword = "JMMSecurePassword!"
$MachineSecurePassword = ConvertTo-SecureString $MachinePassword -AsPlainText -Force
$MachineCredential = New-Object System.Management.Automation.PSCredential ($MachineUserName, $MachineSecurePassword);
$IPconfig = New-AzureRmNetworkInterfaceIpConfig -Name "IPConfig1" -PrivateIpAddressVersion IPv4 -PrivateIpAddress "10.$IP.190.20" -Subnet (Get-AzureRmVirtualNetworkSubnetConfig -name InfrastructureSubnet -VirtualNetwork (Get-AzureRmVirtualNetwork -name JMM_VNet01 -ResourceGroupName JMM_RG01))
$NICName = $VMName+'_NIC01'
$NICObj = New-AzureRmNetworkInterface -Name $NICName -ResourceGroupName JMM_RG01 -Location UKSouth  -IpConfiguration $IPconfig  -WarningAction SilentlyContinue
$VirtualMachine = New-AzureRmVMConfig -VMName $VMName -VMSize $VMSize
$VirtualMachine = Set-AzureRmVMOperatingSystem -VM $VirtualMachine -Windows -ComputerName $VMName -Credential $MachineCredential -ProvisionVMAgent -EnableAutoUpdate
$VirtualMachine = Add-AzureRmVMNetworkInterface -VM $VirtualMachine -Id $NICObj.Id
$VirtualMachine = Set-AzureRmVMSourceImage -VM $VirtualMachine -PublisherName 'MicrosoftWindowsServer' -Offer 'WindowsServer' -Skus '2016-Datacenter' -Version latest
$VirtualMachineObj = New-AzureRmVM -ResourceGroupName JMM_RG01 -Location UKSouth -VM $VirtualMachine -WarningAction SilentlyContinue
Remove-Item .\ADscript.ps1
New-Item -ItemType File -Path .\ADscript.ps1
$Content = 'install-windowsfeature AD-Domain-Services'
Add-Content .\ADscript.ps1 $Content
Invoke-AzureRmVMRunCommand -ResourceGroupName JMM_RG01 -Name $VMName -CommandId 'RunPowerShellScript' -ScriptPath .\ADscript.ps1
Remove-Item .\ADscript.ps1 