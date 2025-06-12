---
description: 
globs: e2e,tests
alwaysApply: false
---
Rule Name: mcp-inspector
Description: Debugging and verifying the Notarium MCP server (`notarium-mcp`) via the MCP Inspector UI. This rule uses Playwright for UI automation, iTerm for server management, and Claude Code for log inspection.

This project IS notarium-mcp, you find the source code in the src folder.

Simplenote test account (credentials currently hardcoded in `src/config.ts` for this testing phase):
steipete@protonmail.com
MAbVuzegRZ2U9dz7wJHi

To read the log, use `tail -n 100 /path/to/logfile.log`

DO NOT RUN BLOCKING TERMINAL COMMANDS VIA YOUR TERMINAL TOOL. INSTEAD USE Terminal app via AppleScript.
Blocking operations include: 
- `node dist/index.js`
- `npm run dev`
- `npm start`

This is ok:
Grab the last X lines: `tail -n 100 server.log`

Run `npm run build` to verify build.

Check iTerm log when the MCP Inspector fails, as it might show errors from our service.

**Required Tools:**
- `run_terminal_cmd` (for global pkill, and as fallback for Inspector start)
- `mcp_iterm-mcp_send_control_character`
- `mcp_iterm-mcp_write_to_terminal`
- `mcp_iterm-mcp_read_terminal_output`
- `mcp_playwright_browser_navigate`
- `mcp_playwright_browser_type`
- `mcp_playwright_browser_click`
- `mcp_playwright_browser_snapshot`
- `mcp_playwright_browser_console_messages`
- `mcp_playwright_browser_wait_for`
- `mcp_claude-code_claude_code`

**User Workspace Path Placeholder:**
- `[WORKSPACE_PATH]` in this rule **MUST** be replaced by the AI assistant with the absolute path to the user's current project workspace (e.g., from `<user_info>`).

---

**Phase 1: Start MCP Inspector Server (via iTerm)**
1.  **Clear iTerm & Kill Existing Inspector Processes:**
    *   Action: `mcp_iterm-mcp_send_control_character`, `letter`: `"C"`. (Stop any current iTerm command).
2.  **Start New Inspector Process in iTerm:**
    *   Action: `mcp_iterm-mcp_write_to_terminal`, `command`: `SIMPLENOTE_USERNAME=steipete@protonmail.com SIMPLENOTE_PASSWORD=MAbVuzegRZ2U9dz7wJHi npx @modelcontextprotocol/inspector ./start.sh`.
    *   Action: `mcp_iterm-mcp_read_terminal_output`, `linesOfOutput`: `7` (or enough to see startup messages clearly).
    *   Verify: Look for "MCP Inspector is up and running at http://127.0.0.1:6274". Note the proxy port.
3.  **Wait for Inspector UI:** `mcp_playwright_browser_wait_for`, `time`: `3` (seconds).

**Phase 2: Connect to Notarium MCP Server via Playwright**
1.  **Navigate/Refresh Inspector Page:**
    *   Action: `mcp_playwright_browser_navigate`, `url`: `http://127.0.0.1:6274`.
    *   Expected: Ensures a fresh state of the Inspector UI.
    *   Snapshot: Take a snapshot.
2.  **Fill Connection Form:**
    *   **Set Command:** (Obtain `ref` from snapshot for "Command textbox")
        *   Action: `mcp_playwright_browser_type`, `text`: `[WORKSPACE_PATH]/start.sh`.
    *   **Set Arguments:** (Obtain `ref` for "Arguments textbox")
        *   Action: `mcp_playwright_browser_type`, `text`: `""`.
    *   **Environment Variables: (prefilled if you add it in the inspector call)**
        *   Action: Click "Environment Variables" button (obtain `ref`) to view current. Snapshot.
`src/config.ts`. No UI entry is strictly needed unless overriding these for a specific test run.
        *   (If needing to override, e.g., `LOG_FILE_PATH=/tmp/custom-notarium.log`):
            *   Click "Add Environment Variable" button (obtain `ref`).
            *   Type key into the new key textbox (obtain `ref`).
            *   Type value into the new value textbox (obtain `ref`). Repeat as needed.
3.  **Click "Connect":** (Obtain `ref` from snapshot for "Connect button")
    *   Action: `mcp_playwright_browser_click`.
    *   Snapshot: Take a snapshot.
4.  **Verify Connection:**
    *   Examine snapshot: Check for connected status (e.g., service `mcp_notarium` appears).
    *   If connection fails, examine "Error output from MCP server" panel in Inspector UI. This shows `stderr` from `start.sh`.
    *   Crucially, also check the `start.sh` debug log: `mcp_claude-code_claude_code`, prompt: `"Read /tmp/notarium_start_debug.log"`.
    *   If `start.sh` log shows it tried to run `notarium-mcp` but Inspector still failed to connect, then check `notarium-mcp`'s own log: `mcp_claude-code_claude_code`, prompt: `"Read [WORKSPACE_PATH]/notarium-server-debug.log"`.

**Phase 3: Interact with `mcp_notarium.list` Tool** (Assuming successful connection)
1.  **List/Select Service:** Click `mcp_notarium` service name. Snapshot.
2.  **Select `mcp_notarium.list` Tool:** Click tool in list. Snapshot.
3.  **Execute Tool (Default Params):** Parameters field should be empty or `{}`. Click "Run Tool". Snapshot.

**Phase 4: Verify Tool Execution and Get Output**
1.  **Check Results in UI:** Examine snapshot for JSON result with `items` array.
2.  **Report Output:** Clearly state the content of the `items` array.
3.  **Check Notarium Server Logs:**
    *   Action: `mcp_claude-code_claude_code`, `prompt`: `"Read last 50 lines of [WORKSPACE_PATH]/notarium-server-debug.log"` (or the configured path).
    *   Look for: Logs related to authentication, sync activity, and `mcp_notarium.list` tool execution.

**Troubleshooting Notes (Consolidated):**
- **Workspace Path:** Ensure `[WORKSPACE_PATH]` is correctly replaced with the absolute path.
- **`start.sh`:** Must be executable. It logs its own debug trace to `/tmp/notarium_start_debug.log`. It **must not** output to `stdout` or `stderr` itself before the actual Notarium server starts sending JSON-RPC, as this will break Inspector parsing.
- **`notarium-mcp` Logs:** The primary logs for the Notarium server itself are in the file specified by `LOG_FILE_PATH` (default `./notarium-server-debug.log` in the project root, configured in `src/config.ts`). Use `mcp_claude-code_claude_code` with `tail -n 100 <path_to_log>` or `Read <path_to_log>`.
- **Inspector UI Errors:** The "Error output from MCP server" panel in the Inspector shows `stderr` from the launched `start.sh` process. This is useful if `start.sh` itself fails loudly.
- **Playwright Refs:** Always use refs from the *latest* snapshot for interactions.
