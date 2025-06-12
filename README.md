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
- **[swift-argument-parser.md](./llms/swift-argument-parser.md)** - Swift Argument Parser framework for building command-line tools
- **[swift6-migration.md](./llms/swift6-migration.md)** - Swift 6 migration guide with concurrency and language changes
- **[mcp-releasing.md](./llms/mcp-releasing.md)** - Generic guide for releasing MCP servers as NPM packages

These documents serve as knowledge references that can be included in CLAUDE.md files to provide AI assistants with up-to-date information about Swift frameworks, APIs, and development workflows.

## Cursor Rules

The `cursor-rules/` directory contains reusable Cursor AI rules and patterns collected from various projects:

### Meta-Rules

- **[cursor-rules-meta-guide.md](./cursor-rules/cursor-rules-meta-guide.md)** - Guidelines for creating and maintaining Cursor rules
  - Rule structure and formatting
  - File reference syntax
  - Best practices for rule documentation

### Automation Patterns

- **[safari-automation.md](./cursor-rules/safari-automation.md)** - Advanced Safari browser automation techniques
  - AppleScript patterns for window/tab management
  - JavaScript execution strategies
  - Shadow DOM interaction
  - Timing and synchronization patterns

- **[mcp-inspector-debugging.md](./cursor-rules/mcp-inspector-debugging.md)** - Debugging MCP servers with Inspector UI
  - Multi-tool orchestration (Playwright, iTerm, Claude Code)
  - Phase-based debugging approach
  - Troubleshooting strategies

These rules demonstrate proven patterns for project development, automation, testing, and debugging that can be adapted for your own projects.

## Claude Code Plan Mode

**New in Claude Code**: Plan mode allows you to review implementation plans before making changes. This feature is perfect for complex changes where you want to nail the approach before diving in.

Plan mode enables Claude to create comprehensive plans for code changes, breaking down tasks into clear steps with file locations and specific modifications. This helps ensure accuracy and allows you to review the approach before any code is written.

**Learn more**: [Announcement tweet by @_catwu](https://x.com/_catwu/status/1932857816131547453)

## Resources

### Blog Posts
- [How I Use Claude Code](https://spiess.dev/blog/how-i-use-claude-code) - Practical tips and workflows for using Claude Code effectively
- [Claude Code is My Computer](https://steipete.me/posts/2025/claude-code-is-my-computer) - Deep dive into Claude Code as a development environment
