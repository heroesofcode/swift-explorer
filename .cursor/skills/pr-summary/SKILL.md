# PR Summary Skill

## Description

Reviews local git changes and generates a pull request summary following the project template.

## Steps

1. **Gather change context** by running the following git commands:
   - `git diff --stat HEAD` — list changed files and line counts
   - `git diff HEAD` — full diff of all changes
   - `git log --oneline origin/main..HEAD` — list commits in this branch

2. **Infer the type of change** from the diff and file list. Common types:
   - `feat` — new feature or functionality added
   - `fix` — bug fix
   - `refactor` — code restructuring without behavior change
   - `chore` — maintenance, dependency updates, config changes
   - `docs` — documentation updates
   - `test` — test additions or changes
   - `ci` — CI/CD workflow changes

3. **Write the summary as topic bullets**, grouping related changes together. Each bullet should be concise and describe *what* changed and *why* (if discernible from the diff).

4. **Output in template format** (see below).

5. **Deliver the result** in a markdown code block and write the content to `pr-description.md` in the repository root.

## Output Template

```markdown
## What changed

- <bullet summarizing change 1>
- <bullet summarizing change 2>

## Why

<One or two sentences explaining the motivation or context for the changes.>

## Type of change

- [ ] Bug fix
- [ ] New feature
- [ ] Refactor
- [ ] Chore / maintenance
- [ ] Documentation
- [ ] Tests
- [ ] CI/CD

## Checklist

- [ ] Code compiles and existing tests pass
- [ ] New tests added (if applicable)
- [ ] Documentation updated (if applicable)
```
