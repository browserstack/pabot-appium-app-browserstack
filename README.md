# Robot Framework (Pabot) + Appium with BrowserStack App Automate

Run Appium mobile-app tests on real devices on [BrowserStack App Automate](https://app-automate.browserstack.com/)
using the BrowserStack SDK with Robot Framework, executed in parallel via **Pabot**.

This repo is self-contained per platform: `android/` (and `ios/` for completeness) each carry their own
`browserstack.yml`, Robot suite, and dependency file.

## Prerequisites

- A [BrowserStack](https://www.browserstack.com/) account (App Automate).
- Python 3.8+.
- The sample apps are pre-uploaded to BrowserStack and referenced by `bs://` URL in `browserstack.yml`.

## Setup

```bash
git clone <this-repo>
cd pabot-appium-app-browserstack/android

python3 -m venv .venv
source .venv/bin/activate          # activate so the SDK CLI resolves from this venv
pip install -r requirements.txt
```

> Activate the virtualenv (`source .venv/bin/activate`) rather than calling
> `.venv/bin/browserstack-sdk` directly. Pabot spawns worker processes that re-invoke
> `browserstack-sdk` by name, so the venv's `bin/` must be first on `PATH`; otherwise a
> system-wide `browserstack-sdk` (e.g. a Ruby gem) can shadow it and the worker never starts a session.

Configure credentials via environment variables (preferred) or by editing `userName`/`accessKey` in
`browserstack.yml`:

```bash
export BROWSERSTACK_USERNAME="YOUR_USERNAME"
export BROWSERSTACK_ACCESS_KEY="YOUR_ACCESS_KEY"
```

## Run Sample Test

From inside the `android/` directory (with the venv activated):

```bash
browserstack-sdk pabot --processes 1 tests/
```

The BrowserStack SDK reads `browserstack.yml`, injects the app + device capabilities into each Appium
session, runs the Robot suite on a real **Samsung Galaxy S22 Ultra**, and reports test context (name,
status) plus Test Observability data to BrowserStack.

## Notes / Dashboard

- Watch your runs live and replay sessions at <https://app-automate.browserstack.com/>.
- Test Observability is enabled (`testObservability: true`) — analytics appear at
  <https://observability.browserstack.com/>.
- `--processes N` controls Pabot parallelism; this sample uses `1`. Increase it (and
  `parallelsPerPlatform`) to fan out across more sessions.
