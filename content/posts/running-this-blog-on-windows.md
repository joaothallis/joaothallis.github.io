+++
date = '2026-08-22T16:36:22-03:00'
draft = false
title = 'Running This Blog on Windows'
+++

This site uses Hugo modules for its theme, so install both Hugo Extended and Go on Windows:

```powershell
winget install -e --id Hugo.Hugo.Extended
winget install -e --id GoLang.Go
```

After installation, open a new PowerShell window so the updated `PATH` is loaded. From the repository directory, start the development server:

```powershell
hugo server -D
```

Hugo resolves and downloads the theme module when needed; you do not need to run `hugo mod get` for a normal startup. Go must be installed and available on `PATH` for Hugo to load the module.
