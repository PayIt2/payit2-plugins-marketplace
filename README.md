# PayIt2 Plugin Marketplace

AI-powered Claude plugins for the [PayIt2](https://payit2.com) platform.

## PayIt2 Campaign Coach

Your AI coach for everything on PayIt2: fundraisers, events, and groups. 5 skills, 4 commands, 3 agents.

**Commands:**
- `/campaign` - Build any campaign from scratch: fundraiser, event, or group
- `/promote` - Generate a full promotion package with social posts, emails, content calendar, and SEO
- `/check-in` - Health check with score, diagnosis, and specific action items
- `/engage` - Personalized messages for supporters: thank-yous, updates, re-engagement, and follow-ups

**Example prompts:**
- *"Help me raise $15,000 for my neighbor's family after a house fire."*
- *"I'm organizing a charity golf tournament for 120 people."*
- *"I need to collect $200 from 25 teammates for new uniforms."*

### Install

**Claude Code (CLI):**

Add the PayIt2 marketplace, then install the plugin:

```bash
/plugin marketplace add PayIt2/payit2-plugins-marketplace
/plugin install payit2-campaign-coach@PayIt2/payit2-plugins-marketplace
```

**Claude Desktop:**

Open the **Customize** menu (under the co-work or code tabs), click **Add Plugin**, and point it to this repo or download the [zip file](https://github.com/PayIt2/payit2-plugins-marketplace/releases/latest/download/payit2-campaign-coach.zip) and install it.

## Install Full Marketplace

Install all PayIt2 plugins at once:

**Claude Code (CLI):**

```bash
/plugin marketplace add PayIt2/payit2-plugins-marketplace
```

Then browse and install plugins with `/plugin`.

**Claude Desktop:**

Open the **Customize** menu (under the co-work or code tabs), click **Add Plugin**, and point it to this repo or download the [zip file](https://github.com/PayIt2/payit2-plugins-marketplace/archive/refs/heads/main.zip) and install it.

## About PayIt2

PayIt2 is an online payment collection platform founded in 2007 in Grand Rapids, MI. We help organizers of events, fundraisers, clubs, and group activities collect payments from supporters.

**Website:** [payit2.com](https://www.payit2.com)

## Author

Built by [Brian Anderson](https://github.com/brianmatic), PayIt2 Founder.
