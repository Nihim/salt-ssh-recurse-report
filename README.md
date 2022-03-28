# Disclaimer
The setup of salt-ssh and the containers themselves has been done without consideration for security as the containers have been created to run inside their own network!

## What is this?
This is a simple example to showcase, what I find, is a weird behaviour of file.recurse in two cases:
1. when one or more of the source files do not have sufficient permissions for the salt-ssh user to read them.
Salt-ssh will show in debug the files it can access but results in `Recurse failed: **none** of the specified sources were found`
2. if there is in addition to the file.recurse, a file.managed using as source one of the files that are accessible, then file.recurse will report that it succeeded but only for the file set in file.managed

## Steps to reproduce both scenarios
- Clone the repo
- docker-compose up -d
- docker-compose exec salt-ssh bash

### For #1
- salt-ssh -i '*' state.apply foo test=true -l debug
- rm -rf dir1/file5
- re-run state.apply

### For #2
- salt-ssh -i '*' state.apply foo2 test=true -l debug
- change the source file in file.managed to file{1..4} or rm dir2/file5
- re-run state.apply
