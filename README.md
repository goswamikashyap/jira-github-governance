# Jira-GitHub Governance Automation
# Jira-GitHub Governance & Compliance Automation

Automated DevSecOps governance pipeline that enforces Jira ticket traceability on every commit, syncs deployment metadata to Jira issues, and archives immutable JSON audit logs in AWS S3.

## Architecture & Governance Gates
1. **Local Pre-Commit Enforcement (`commit-msg` Hook):** Intercepts `git commit` locally and blocks commits that do not follow the `SCRUM-<ID>: <description>` format.
2. **Server-Side CI Validation (GitHub Actions):** Re-validates commit messages on push/PR events to prevent `--no-verify` bypasses.
3. **Automated Jira Traceability:** Extracts the Jira ticket ID and posts the commit SHA, author, and repository link directly to the corresponding Jira ticket via the Jira REST API v3.
4. **Immutable S3 Audit Trail:** Generates a structured JSON compliance record for every passing build and uploads it to a private AWS S3 bucket.

## Repository Structure

