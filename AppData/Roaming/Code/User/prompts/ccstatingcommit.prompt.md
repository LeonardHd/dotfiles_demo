---
name: ccommit-staging
description: Create a Conventional Commits compliant git commit for staged files.
argument-hint: Summarize the staged code changes
---
Review the staged code changes and craft a commit message following the Conventional Commits specification.

## Steps:
1. Run `git status` to see staged files ready for commit
2. Run `git diff --cached` to examine the actual code changes in staged files
3. Analyze the staged changes to understand:
   - What was added, modified, or removed
   - The purpose and intent behind the changes
   - Any patterns or themes across multiple file changes
4. Craft a commit message following Conventional Commits format
5. Commit the staged changes with the crafted message

## Conventional Commits Format:
```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### Types:
- `feat`: A new feature (correlates with MINOR in SemVer)
- `fix`: A bug fix (correlates with PATCH in SemVer)
- `docs`: Documentation only changes
- `style`: Changes that do not affect the meaning of the code (formatting, etc.)
- `refactor`: A code change that neither fixes a bug nor adds a feature
- `perf`: A code change that improves performance
- `test`: Adding missing tests or correcting existing tests
- `build`: Changes that affect the build system or external dependencies
- `ci`: Changes to CI configuration files and scripts
- `chore`: Other changes that don't modify src or test files

### Rules:
- Use imperative mood ("Add feature" not "Added feature")
- First line (description): brief summary, ideally 50 chars or less
- Scope is optional and describes the section of codebase, e.g., `feat(parser):`
- For breaking changes: append `!` after type/scope or add `BREAKING CHANGE:` footer
- Body: explain what and why (not how), separated by blank line from description
- Footers: use format `Token: value` or `Token #value`, e.g., `Refs: #123`

### Examples:
- `feat: add user authentication`
- `fix(api): resolve null pointer in request handler`
- `docs: update README with installation instructions`
- `feat!: drop support for Node 12`

## Output:
- A summary for the human explaining what changes were made and why
- Execute the git commit with the crafted message
