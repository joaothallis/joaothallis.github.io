+++
date = '2026-11-22T16:07:49-03:00'
draft = false
title = 'Chocolatey Terraform install: permission/lock error'
+++

Running `choco install terraform` in a non-elevated PowerShell session failed. Chocolatey warned that the shell was not elevated, then reported a lock-file access problem and denied access to its default package directory under `C:\ProgramData\chocolatey`.

## Failed attempt: non-elevated PowerShell

**Command:**

```powershell
choco install terraform
```

**Output:**

```powershell
Chocolatey detected you are not running from an elevated command shell
(cmd/powershell).

You may experience errors - many functions/packages
require admin rights.
```

After confirming the prompt, Chocolatey downloaded the package and then failed with lock-file and access errors:

```powershell
Unable to obtain lock file access on 'C:\ProgramData\chocolatey\lib\...'
for operations on 'C:\ProgramData\chocolatey\lib\terraform'.

Access to the path 'C:\ProgramData\chocolatey\lib-bad' is denied.
Chocolatey installed 0/0 packages.
```

## Successful attempt: elevated PowerShell

**Command:**

```powershell
choco install terraform
```

**Output:**

```powershell
terraform v1.17.2 [Approved]
Downloading terraform 64 bit
  from 'https://releases.hashicorp.com/terraform/1.17.2/terraform_1.17.2_windows_amd64.zip'
Progress: 100% - Completed download

ShimGen has successfully created a shim for terraform.exe
The install of terraform was successful.
Deployed to 'C:\ProgramData\chocolatey\lib\terraform\tools'
```

When prompted to run the package script, select `Y` to continue:

```powershell
Do you want to run the script?([Y]es/[A]ll scripts/[N]o/[P]rint):
Y
```

## Verification
```powershell
terraform version
Terraform v1.17.2
on windows_amd64
```

## Takeaway

The non-elevated attempt could not write to Chocolatey's default package location. Installing from an elevated shell succeeded. If using Chocolatey without elevation, follow its [non-administrative setup instructions](https://docs.chocolatey.org/en-us/choco/setup#non-administrative-install). Do not remove a lock file while another Chocolatey install may be running.
