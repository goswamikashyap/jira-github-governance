# Jira-GitHub Governance & Compliance Automation

Automated DevSecOps governance pipeline that enforces Jira ticket traceability on every commit, syncs deployment metadata to Jira issues, and archives immutable JSON audit logs in AWS S3.

## Architecture & Governance Gates
1. **Local Pre-Commit Enforcement (`commit-msg` Hook):** Intercepts `git commit` locally and blocks commits that do not follow the `SCRUM-<ID>: <description>` format.
2. **Server-Side CI Validation (GitHub Actions):** Re-validates commit messages on push/PR events to prevent `--no-verify` bypasses.
3. **Automated Jira Traceability:** Extracts the Jira ticket ID and posts the commit SHA, author, and repository link directly to the corresponding Jira ticket via the Jira REST API v3.
4. **Immutable S3 Audit Trail:** Generates a structured JSON compliance record for every passing build and uploads it to a private AWS S3 bucket.

## Repository Structure
text ├── .github/workflows/ │   └── governance.yml      # CI validation, Jira REST API sync, and S3 upload ├── scripts/ │   ├── commit-msg          # Regex-based Git commit-message hook │   └── install-hooks.sh    # One-click local Git hook installer └── README.md 

## Quick Start
1. **Clone the repository:**
   ```bash
   git clone https://github.com/goswamikashyap/jira-github-governance.git
   cd jira-github-governance
   ```
2. **Activate the local Jira governance hook:**
   ```bash
   chmod +x scripts/install-hooks.sh && ./scripts/install-hooks.sh
   ```
3. **Configure GitHub Repository Secrets:**
   Add the following secrets under **Settings → Secrets and variables → Actions**:
   - `JIRA_BASE_URL`
   - `JIRA_EMAIL`
   - `JIRA_API_TOKEN`
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
   - `AWS_S3_BUCKET`

## Sample S3 Compliance Audit Record
```json
{
  "jira_ticket": "SCRUM-13",
  "commit_sha": "c3e8b0abf0033851cf32537de0a607af6e11be7d",
  "author": "goswamikashyap",
  "repository": "goswamikashyap/jira-github-governance",
  "status": "COMPLIANT",
  "timestamp_utc": "20261117T132159Z"
}
```
## Live Proof of Execution
1. GitHub Actions run (governance-and-audit with all 4 steps expanded).

<img width="1280" height="688" alt="1" src="https://github.com/user-attachments/assets/150ed8c8-d33a-4bd2-9950-522d0df00be3" />
3. Jira SCRUM-13 ticket showing the automated "Automated Governance Check Passed.

   <img width="1280" height="685" alt="2" src="https://github.com/user-attachments/assets/f4619fb3-a4f9-42d1-bc7c-e27499361615" />
4. AWS S3 audit-logs
   
   <img width="1280" height="562" alt="3" src="https://github.com/user-attachments/assets/e85b8417-afaf-4857-bca9-d026fbf5ba43" />

   
