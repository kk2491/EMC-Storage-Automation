# Powershell script to collect the NAR files from EMC Storage array

## Storage models supported - EMC VNX and EMC Clariion arrays

### Note : This would give the last 5 days NAR files for both SPA and SPB

### Prerequisites : 
Please maintain a text file with name Array.txt in the below format
Array_Name SPA_IP_Address SPB_IP_Address in the same folder where you have NAR exe file

### Steps given below

1.  Copy the exe folder from Github to any folder in the server from where you can access storage array using naviseccli.

2.  Open the EMC_NAR.exe file.

3.  You would be prompted to enter the array name.
    
4.  Enter the array name as you have updated in the Array.txt file.

5.  Click on "NAR Files" Button.

6.  NAR Files collection would start and you could see the NAR files are being copied to the directory.

7.  Please try and raise issues if you face any difficulties.
