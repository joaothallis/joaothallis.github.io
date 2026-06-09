---
title: "How to Sign All Commits of My Branch That Are Missing to Be Signed"
date: 2026-03-22T11:00:00-03:00
draft: false
---

Sometimes you end up with a branch where some commits are not GPG signed. This can happen when you switch machines or forget to enable commit signing. Here is how to fix it.

## Checking for unsigned commits

First, check which commits on your branch are unsigned:

```bash
git log --pretty='%h %G? %s' $(git merge-base main HEAD)..HEAD
```

The `%G?` format shows the signature status of each commit: `G` means a good signature, `N` means no signature.

## Signing all commits

If you want to re-sign every commit on your branch:

```bash
git rebase --exec 'git commit --amend --no-edit -S' $(git merge-base main HEAD)
```

This replays each commit and amends it with the `-S` flag, which adds your GPG signature. The `git merge-base main HEAD` finds the point where your branch diverged from `main`.

## Signing only unsigned commits

If some commits are already signed and you only want to sign the missing ones:

```bash
FILTER_BRANCH_SQUELCH_WARNING=1 git filter-branch --force --commit-filter '
  status="$(git log -1 --format=%G? "$GIT_COMMIT")"
  if [ "$status" = "N" ]; then
    git commit-tree -S "$@"
  else
    git commit-tree "$@"
  fi' $(git merge-base main HEAD)..HEAD
```

The `if` condition checks whether each commit has no signature (`N`). Only unsigned commits get amended with a GPG signature. Already-signed commits are left untouched.

## Verifying the result

Run the same log command again to confirm all commits are now signed:

```bash
git log --pretty='%h %G? %s' $(git merge-base main HEAD)..HEAD
```

Every commit should now show `G` instead of `N`.
