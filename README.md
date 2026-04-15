# PayIt2 Plugin Marketplace

AI-powered Claude plugins for the [PayIt2](https://payit2.com) platform.

## PayIt2 Campaign Assistant v1.4

Your AI assistant for everything on PayIt2: fundraisers, events, and groups. 9 skills, 3 agents with MCP integration and session hooks.

### Install

**Full marketplace** (includes all PayIt2 plugins):

Download [payit2-plugins-marketplace.zip](https://github.com/PayIt2/payit2-plugins-marketplace/releases/latest/download/payit2-plugins-marketplace.zip) and upload via Settings > Plugins > Upload to a new marketplace.

**Single plugin:**

Download [payit2-campaign-assistant-plugin.zip](https://github.com/PayIt2/payit2-plugins-marketplace/releases/latest/download/payit2-campaign-assistant-plugin.zip) and upload via Settings > Plugins > Upload plugin.

**Individual skills:**

| Skill | Download |
|-------|----------|
| Campaign Creation | [campaign-creation-skill.zip](https://github.com/PayIt2/payit2-plugins-marketplace/releases/latest/download/campaign-creation-skill.zip) |
| Campaign Analytics | [campaign-analytics-skill.zip](https://github.com/PayIt2/payit2-plugins-marketplace/releases/latest/download/campaign-analytics-skill.zip) |
| Campaign Promotion | [campaign-promotion-skill.zip](https://github.com/PayIt2/payit2-plugins-marketplace/releases/latest/download/campaign-promotion-skill.zip) |
| Campaign Context | [campaign-context-skill.zip](https://github.com/PayIt2/payit2-plugins-marketplace/releases/latest/download/campaign-context-skill.zip) |
| Supporter Engagement | [supporter-engagement-skill.zip](https://github.com/PayIt2/payit2-plugins-marketplace/releases/latest/download/supporter-engagement-skill.zip) |
| Campaign (create & launch) | [campaign-skill.zip](https://github.com/PayIt2/payit2-plugins-marketplace/releases/latest/download/campaign-skill.zip) |
| Check-in (health check) | [check-in-skill.zip](https://github.com/PayIt2/payit2-plugins-marketplace/releases/latest/download/check-in-skill.zip) |
| Promote (promotion strategy) | [promote-skill.zip](https://github.com/PayIt2/payit2-plugins-marketplace/releases/latest/download/promote-skill.zip) |
| Engage (supporter comms) | [engage-skill.zip](https://github.com/PayIt2/payit2-plugins-marketplace/releases/latest/download/engage-skill.zip) |

Upload any skill zip via Settings > Plugins > Upload skill.

### Skills

| Skill | What it does |
|-------|-------------|
| `/campaign` | Build any campaign from scratch with story, title, goal, ticketing, cost-splitting, and launch strategy |
| `/promote` | Generate a complete promotion package: social posts, email sequences, content calendar, and SEO recommendations |
| `/check-in` | Health check on any active campaign with a score, diagnosis, and specific action items |
| `/engage` | Personalized messages for supporters: thank-yous, updates, re-engagement, share requests, and follow-ups |

### Example Prompts

- *"My neighbor's house burned down. Help me raise $15,000 for her family."*
- *"I'm organizing a charity golf tournament for 120 people. Help me set up ticketing."*
- *"I need to collect $200 from each of 25 teammates for new uniforms."*
- *"My campaign has been live 2 weeks and donations have stalled. What do I do?"*
- *"Write a week's worth of social posts for my campaign - we just hit 50%."*

### Plugin Contents

- **9 skills:** Campaign, check-in, promote, engage, campaign creation, analytics, promotion, context, and supporter engagement
- **3 agents:** Campaign assistant, content generator, supporter outreach
- **MCP server** for live PayIt2 API connectivity
- **Session hooks** for automatic context loading and campaign URL detection

## Development

Plugin source files live in the [payit2-campaign-assistant](https://github.com/PayIt2/payit2-campaign-assistant) repo. This repo contains only the marketplace manifest and build tooling.

To rebuild zips locally (requires the source repo cloned as a sibling):

```bash
bash scripts/build-zips.sh
```

## About PayIt2

PayIt2 is an online payment collection platform that has helped organizers collect millions for fundraisers, events, and group activities.

**Website:** [payit2.com](https://www.payit2.com)

## Author

Built by [Brian Anderson](https://github.com/brianmatic), PayIt2 Founder.
