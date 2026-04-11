# PayIt2 Plugin Marketplace

AI-powered Claude plugins for the [PayIt2](https://payit2.com) platform.

## PayIt2 Campaign Coach v1.2

Your AI coach for everything on PayIt2: fundraisers, events, and groups. 5 skills, 4 commands, 3 agents - now with MCP integration and session hooks.

### What's New in v1.2

- **MCP server integration** for live PayIt2 API connectivity
- **Session hooks** for automatic context loading, campaign URL detection, and session summaries
- **Updated agents** with improved coaching and content generation

### Commands

| Command | What it does |
|---------|-------------|
| `/campaign` | Build any campaign from scratch - fundraiser, event, or group - with story, title, goal, ticketing, cost-splitting, and launch strategy |
| `/promote` | Generate a complete promotion package: social posts, email sequences, content calendar, and SEO recommendations |
| `/check-in` | Health check on any active campaign with a score, diagnosis, and specific action items |
| `/engage` | Personalized messages for supporters: thank-yous, updates, re-engagement, share requests, and follow-ups |

### Example Prompts

- *"My neighbor's house burned down. Help me raise $15,000 for her family."*
- *"I'm organizing a charity golf tournament for 120 people. Help me set up ticketing."*
- *"I need to collect $200 from each of 25 teammates for new uniforms."*
- *"My campaign has been live 2 weeks and donations have stalled. What do I do?"*
- *"Write a week's worth of social posts for my campaign - we just hit 50%."*

### Install

**Download:** Grab the [latest zip](https://github.com/PayIt2/payit2-plugins-marketplace/releases/latest/download/payit2-campaign-coach.zip) from the releases page.

**Claude Code (CLI):**

```bash
claude plugin install payit2-campaign-coach@marketplace
```

Or load for a single session:

```bash
claude --plugin-dir ./payit2-campaign-coach
```

### Plugin Structure

```
payit2-campaign-coach/
  .claude-plugin/plugin.json    # Plugin manifest (v1.2.0)
  .mcp.json                     # MCP server configuration
  hooks/hooks.json              # Session and event hooks
  scripts/                      # Hook helper scripts
  skills/                       # 5 workflow skills
  commands/                     # 4 slash commands
  agents/                       # 3 autonomous agents
```

## Install Full Marketplace

Install all PayIt2 plugins at once by downloading the [full marketplace zip](https://github.com/PayIt2/payit2-plugins-marketplace/releases/latest/download/payit2-plugins-marketplace.zip) from the releases page.

## About PayIt2

PayIt2 is an online payment collection platform founded in 2007 in Grand Rapids, MI. We help organizers of events, fundraisers, clubs, and group activities collect payments from supporters.

**Website:** [payit2.com](https://www.payit2.com)

## Author

Built by [Brian Anderson](https://github.com/brianmatic), PayIt2 Founder.
