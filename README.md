# agent-rules
Rules and Knowledge to work better with agents such as Claude Code or Cursor

## Available Rules

### GitHub Issue Creation
**Credit**: [@nityeshaga](https://x.com/nityeshaga/status/1933113428379574367)

A comprehensive rule for creating well-structured GitHub issues from feature descriptions. This rule guides AI assistants through a 5-step process:

1. **Research the repository** - Examines existing issues, documentation, and contribution guidelines
2. **Research best practices** - Studies current standards and examples from popular projects
3. **Present a plan** - Outlines the proposed issue structure with labels and milestones
4. **Create the issue** - Drafts complete issue content with title, description, and acceptance criteria
5. **Final output** - Provides ready-to-use GitHub issue content

**Usage**: Add the content from `github-issue-creation.md` to your global or project-specific CLAUDE.md file.

**Location**: [`github-issue-creation.md`](./github-issue-creation.md)

## LLM Documentation

The `llms/` directory contains reference documentation for working with Large Language Models, particularly focused on Swift development:

- **[swift-observable.md](./llms/swift-observable.md)** - Documentation for Swift's @Observable macro and observation framework
- **[swift-observation.md](./llms/swift-observation.md)** - Swift Observation framework details and patterns
- **[swift-testing-api.md](./llms/swift-testing-api.md)** - Swift Testing framework API reference
- **[swift-testing-playbook.md](./llms/swift-testing-playbook.md)** - Best practices and patterns for Swift Testing

These documents serve as knowledge references that can be included in CLAUDE.md files to provide AI assistants with up-to-date information about Swift frameworks and APIs.
