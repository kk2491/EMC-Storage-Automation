Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form 
$form.Text = "Data Entry Form"
$form.Size = New-Object System.Drawing.Size(400,300) 
$form.StartPosition = "CenterScreen"

$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Point(75,120)
$OKButton.Size = New-Object System.Drawing.Size(80,30)
$OKButton.Text = "SP Collect"
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $OKButton
$form.Controls.Add($OKButton)

$HealthButton = New-Object System.Windows.Forms.Button
$HealthButton.Location = New-Object System.Drawing.Point(150,120)
$HealthButton.Size = New-Object System.Drawing.Size(80,30)
$HealthButton.Text = "Health Check"
$HealthButton.DialogResult = [System.Windows.Forms.DialogResult]::Yes
#$form.HealthButton = $HealthButton
$form.Controls.Add($HealthButton)

$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Point(225,120)
$CancelButton.Size = New-Object System.Drawing.Size(80,30)
$CancelButton.Text = "Cancel"
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $CancelButton
$form.Controls.Add($CancelButton)


$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(100,20) 
$label.Size = New-Object System.Drawing.Size(280,40) 
$label.Text = "Please Enter the Array Name"
$form.Controls.Add($label) 

$textBox = New-Object System.Windows.Forms.TextBox 
$textBox.Location = New-Object System.Drawing.Point(50,60) 
$textBox.Size = New-Object System.Drawing.Size(260,40) 
$form.Controls.Add($textBox) 

$form.Topmost = $True

$form.Add_Shown({$textBox.Select()})
$result = $form.ShowDialog()

$option1 = [System.StringSplitOptions]::RemoveEmptyEntries
$option2 = [System.StringSplitOptions]::RemoveEmptyEntries


if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
	echo "SP Collect"
    	$x = $textBox.Text
    	$x
	$value = $textBox.Text
	Get-Content Array.txt | findstr $value >> lg.txt
	$var_1 = Get-Content lg.txt
	$var_2 = $var_1.Split('' , $option2)
	$var_3 = $var_2[1]
	$var_4 = $var_2[2]

	echo $var_2[1]
	echo $var_2[2]

	naviseccli -h $var_3 -user username -password password -scope 0 spcollect
	Start-sleep 5
	echo "Started SPA SP Collect"
	naviseccli -h $var_4 -user username -password password -scope 0 spcollect
	echo "Started SPB SP Collect"
	Start-sleep 900
	naviseccli -h $var_3 -user username -password password -scope 0 managefiles -list >> log1.txt
	$date = Get-Date -format MM/dd/yy
	Get-Content log1.txt | findstr $date | findstr data >> log2.txt
	$data1 = Get-Content log2.txt
	$data2 = $data1.Split('' , $option1)
	echo y | naviseccli -h $var_3 -user username -password password -scope 0 managefiles -retrieve -file $data2[4]

	Start-sleep 5
	naviseccli -h $var_4 -user username -password password -scope 0 managefiles -list >> log3.txt
	$date = Get-Date -format MM/dd/yy
	Get-Content log3.txt | findstr $date | findstr data >> log4.txt
	$data3 = Get-Content log4.txt
	$data4 = $data3.Split('' , $option1)
	echo y | naviseccli -h $var_4 -user username -password password -scope 0 managefiles -retrieve -file $data4[4]

	Del lg.txt
	Del log1.txt
	Del log2.txt
	Del log3.txt
	Del log4.txt
}

if ($result -eq [System.Windows.Forms.DialogResult]::Yes)
{
   	echo "Health Check"
	$x = $textBox.Text
    	$x
	$value = $textBox.Text
	Get-Content Array.txt | findstr $value >> lg.txt
	$var_1 = Get-Content lg.txt
	$var_2 = $var_1.Split('' , $option2)
	$var_3 = $var_2[1]
	$var_4 = $var_2[2]

	echo $var_2[1]
	echo $var_2[2]

	echo "SPA Status"
	naviseccli -h $var_3 -user username -password password -scope 0 faults -list
	echo "SPB Status"	
	naviseccli -h $var_4 -user username -password password -scope 0 faults -list
	Del lg.txt
	Start-sleep 15
}


if ($result -eq [System.Windows.Forms.DialogResult]::Cancel)
{
 	Exit
}
