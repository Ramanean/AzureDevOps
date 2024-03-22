#Adding LocalUsers as Admin
try{ Set-LocalUser -Name $(AgentUserName) -Password $(AgentePassword)}
catch { "User already present" }
#Adding the user to Administrators
try { Add-LocalGroupMember -Group Administrators -Member -$(AgentUserName)}
catch { "User already Added as Administrator" }
#Downloading the Agent Zip files and Expanding the Archive
Invoke-WebRequest $myDownloadUrl -OutFile C:\$(AgentVersion).zip
Expand-Archive -Path c:\$(AgentVersion).Zip -DestinationPath c:\$(AgentFolder) -Force
#Configuring the Agent
cd c:\$(AgentFolder)
.\config.cmd --unattended --url $(AgentOrg) --auth pat --token $(AgentPATToken) --pool $(AgentPool) --agent $(MachineName)$(AgentUserName) --runAsAutoLogon --windowsLogonAccount $(AgentUserName) --windowsLogonPassword $(AgentPassword) --overwriteautologon

