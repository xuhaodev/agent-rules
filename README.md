# Agent Rules

A collection of reusable rules and knowledge documents for AI coding assistants like Claude Code and Cursor.

## Why This Format?

This repository uses the `.mdc` (Markdown with Configuration) format, which provides a unified approach that works seamlessly with both Claude Code and Cursor:

- **Cursor** natively supports `.mdc` files with YAML frontmatter for rule configuration
- **Claude Code** reads the markdown content, ignoring the frontmatter metadata
- The YAML frontmatter provides optional metadata (description, file globs, alwaysApply) that Cursor uses for intelligent rule application
- Standard markdown content ensures compatibility across different AI assistants

This unified format means you can use the same rule files in both tools without modification.

## Usage

### For Cursor Users
1. Copy any `.mdc` file to your project's `.cursor/rules/` directory
2. Cursor will automatically apply rules based on the glob patterns in the frontmatter
3. Rules with `alwaysApply: true` will be active for all files

### For Claude Code Users
1. Copy the content of any `.mdc` file (excluding the frontmatter) into your `CLAUDE.md` file
2. Or reference the entire file using the `@import` syntax in your `CLAUDE.md`
3. Place in your project root or `~/.claude/CLAUDE.md` for global rules

## Available Rules

### Swift Development
- **[swift-observable.mdc](./swift-observable.mdc)** - Migration guide from ObservableObject to @Observable macro
- **[swift-observation.mdc](./swift-observation.mdc)** - Swift Observation framework documentation
- **[swift-testing-api.mdc](./swift-testing-api.mdc)** - Swift Testing framework API reference
- **[swift-testing-playbook.mdc](./swift-testing-playbook.mdc)** - Comprehensive guide for migrating to Swift Testing
- **[swift-argument-parser.mdc](./swift-argument-parser.mdc)** - Swift Argument Parser framework documentation
- **[swift6-migration.mdc](./swift6-migration.mdc)** - Guide for migrating to Swift 6 with concurrency

### MCP Development
- **[mcp-best-practices.mdc](./mcp-best-practices.mdc)** - Best practices for building Model Context Protocol servers
- **[mcp-releasing.mdc](./mcp-releasing.mdc)** - Guide for releasing MCP servers as NPM packages
- **[mcp-inspector-debugging.mdc](./mcp-inspector-debugging.mdc)** - Debugging MCP servers with Inspector UI

### Automation & Tools
- **[safari-automation.mdc](./safari-automation.mdc)** - Advanced Safari browser automation techniques
- **[screenshot-automation.mdc](./screenshot-automation.mdc)** - AppleScript patterns for automated screenshots
- **[github-issue-creation.mdc](./github-issue-creation.mdc)** - Creating well-structured GitHub issues (Credit: [@nityeshaga](https://x.com/nityeshaga/status/1933113428379574367))

### Meta Rules
- **[cursor-rules-meta-guide.mdc](./cursor-rules-meta-guide.mdc)** - Guidelines for creating and maintaining Cursor rules
- **[continuous-improvement.mdc](./continuous-improvement.mdc)** - Systematic approach for improving AI assistant rules

## Contributing

Feel free to contribute your own rules! Please ensure they:
1. Use the `.mdc` extension
2. Include proper YAML frontmatter with `description`, `globs`, and `alwaysApply` fields
3. Contain clear, actionable instructions
4. Are generic enough to be reused across projects

## License

MIT License - See [LICENSE](./LICENSE) for details