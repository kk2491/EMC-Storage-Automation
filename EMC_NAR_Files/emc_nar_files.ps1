Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form 
$form.Text = "NAR Files Collection"
$form.Size = New-Object System.Drawing.Size(400,300) 
$form.StartPosition = "CenterScreen"

$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Point(75,120)
$OKButton.Size = New-Object System.Drawing.Size(120,30)
$OKButton.Text = "NAR Files"
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $OKButton
$form.Controls.Add($OKButton)

$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Point(225,120)
$CancelButton.Size = New-Object System.Drawing.Size(120,30)
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
	echo "NAR Files Collection"
    	$x = $textBox.Text
    	$x
	$value = $textBox.Text
	Get-Content Array.txt | findstr $value >> lg.txt
	$var1 = Get-Content lg.txt
	$var2 = $var1.Split('' , $option2)
	$var3 = $var2[1]
	$var4 = $var2[2]

	echo $var2[1]
	echo $var2[2]


	naviseccli -h $var3 -user username -password password -scope 0 analyzer -archive -list >> log1.txt
	naviseccli -h $var4 -user username -password password -scope 0 analyzer -archive -list >> log2.txt

	$date1 = Get-Date -format MM/dd/yyyy
	Get-Content log1.txt | findstr $date1 >> File_1.txt
	Get-Content log2.txt | findstr $date1 >> File_2.txt

	$date2 = (Get-Date (Get-date).addDays(-1) -format MM/dd/yyyy)
	Get-Content log1.txt | findstr $date2 >> File_1.txt
	Get-Content log2.txt | findstr $date2 >> File_2.txt

	$date3 = (Get-Date (Get-date).addDays(-2) -format MM/dd/yyyy)
	Get-Content log1.txt | findstr $date3 >> File_1.txt
	Get-Content log2.txt | findstr $date3 >> File_2.txt

	$date4 = (Get-Date (Get-date).addDays(-3) -format MM/dd/yyyy)
	Get-Content log1.txt | findstr $date4 >> File_1.txt
	Get-Content log2.txt | findstr $date4 >> File_2.txt
	
	$date5 = (Get-Date (Get-date).addDays(-4) -format MM/dd/yyyy)
	Get-Content log1.txt | findstr $date5 >> File_1.txt
	Get-Content log2.txt | findstr $date5 >> File_2.txt
	
	$date6 = (Get-Date (Get-date).addDays(-5) -format MM/dd/yyyy)
	Get-Content log1.txt | findstr $date6 >> File_1.txt
	Get-Content log2.txt | findstr $date6 >> File_2.txt
	
	$date7 = (Get-Date (Get-date).addDays(-6) -format MM/dd/yyyy)
	Get-Content log1.txt | findstr $date7 >> File_1.txt
	Get-Content log2.txt | findstr $date7 >> File_2.txt

	foreach ($line in Get-Content File_1.txt)
	{
		$data1 = $line.Split('', $option1)
		echo $data1[4] >> File_3.txt
	}	

	foreach ($line in Get-Content File_3.txt)	
	{
		naviseccli -h $var3 -user username -password password -scope 0 analyzer -archiveretrieve -file $line
	}

	foreach ($line in Get-Content File_2.txt)
	{
		$data2 = $line.Split('', $option1)
		echo $data2[4] >> File_4.txt
	}	

	foreach ($line in Get-Content File_4.txt)	
	{
		naviseccli -h $var4 -user username -password password -scope 0 analyzer -archiveretrieve -file $line
	}

	Del lg.txt
	Del log1.txt
	Del log2.txt
	Del File_1.txt
	Del File_2.txt
	Del File_3.txt
	Del File_4.txt

}

if ($result -eq [System.Windows.Forms.DialogResult]::Cancel)
{
 	Exit
}
