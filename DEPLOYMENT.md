# Local CI/CD Deployment

This project deploys on every push to `main` using a GitHub Actions self-hosted runner installed on your local server. It does not use Docker.

## 1. Install the runner on your local server

In GitHub, open:

`Settings -> Actions -> Runners -> New self-hosted runner`

Choose your server operating system and follow GitHub's commands to download, configure, and start the runner.

When GitHub asks for runner labels, add:

```text
local-server
```

The workflow uses:

```yaml
runs-on: [self-hosted, local-server]
```

## 2. Install Node.js

Install Node.js 20 on the local server. The workflow will run:

```bash
npm ci
npm run build
```

For local development on Windows PowerShell, use:

```powershell
npm.cmd install
npm.cmd start
```

This project uses React 17, so `.npmrc` enables `legacy-peer-deps=true` to avoid newer peer dependency conflicts during install.

## 3. Set the deploy folder

By default the app deploys to:

```text
C:\inetpub\wwwroot\its_birthday
```

To use another folder, add a GitHub repository variable:

`Settings -> Secrets and variables -> Actions -> Variables -> New repository variable`

Name:

```text
LOCAL_DEPLOY_PATH
```

Value example:

```text
D:\sites\its_birthday
```

## 4. Push to deploy

After the runner is online, every push to `main` will:

1. Check out the repository.
2. Install dependencies with `npm ci`.
3. Build the React app.
4. Mirror the `build` folder to the local deploy folder.

You can also run it manually from:

`Actions -> Deploy to local server -> Run workflow`
