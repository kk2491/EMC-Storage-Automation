# Powershell script to collect the NAR files from EMC Storage array

## Storage models supported - EMC VNX and EMC Clariion arrays

### Note : This would give the last 5 days NAR files for both SPA and SPB

### Prerequisites : 
Please maintain a text file with name Array.txt in the below format
Array_Name SPA_IP_Address SPB_IP_Address in the same folder where you have NAR exe file

### Steps given below

1.  Copy the exe folder from Github to any folder in the server from where you can access storage array using naviseccli.  ![](images/Image_NAR_1.png)

2.  Format of Array details in Array.txt is as given below  ![](images/Image_NAR_2.png)

3.  Open the exe file (NAR_v1.exe), this would open up a GUI.  ![](images/Image_NAR_3.png)

4.  Enter the array name in the Textbox and click NAR Files button.  ![](images/Image_NAR_4.png)
    
5.  GUI will be closed and command window be open until the execution is completed.  ![](images/Image_NAR_5.png)

6.  NAR files will start getting downloaded instantly to the same folder.   ![](images/Image_NAR_6.png)

7.  After the completion command window will be closed and last 7 days (including present day) NAR files for both SPA and SPB will be found in the same folder.  ![](images/Image_NAR_7.png)
