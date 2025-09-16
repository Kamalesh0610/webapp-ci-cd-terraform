# AWS DevOps Static Web App Demo

## Architecture Diagram

```mermaid
flowchart TD
    Dev[Developer Pushes Code] -->|GitHub Actions| CI[CI/CD Pipeline]
    CI -->|Sync Static Files| S3[S3 Bucket (Static Website)]
    S3 -->|Origin| CF[CloudFront Distribution]
    User[End User] -->|Access via HTTPS| CF
    CF -->|Serves Content| User
```

---

## Tech Stack Justification

- **HTML/CSS/JS:** Simple, fast, and portable static web app.
- **AWS S3:** Reliable, scalable, and cost-effective static site hosting.
- **AWS CloudFront:** Global CDN for fast, secure content delivery.
- **Terraform:** Infrastructure as Code for reproducibility and automation.
- **GitHub Actions:** Automated CI/CD pipeline for seamless deployment.
- **GitHub Secrets:** Secure management of credentials and resource IDs.

---

## Setup Steps

### 1. **Provision Infrastructure**

```sh
cd iac
terraform init
terraform apply
```
- Note the outputs: `s3_bucket_name`, `cloudfront_distribution_id`, and `website_url`.

### 2. **Configure GitHub Secrets**

Add these secrets in your GitHub repository:
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `S3_BUCKET_NAME` (from Terraform output)
- `CF_DIST_ID` (from Terraform output)

### 3. **Move Workflow File**

Ensure your workflow file is at `.github/workflows/deploy.yml`.

### 4. **Push Code**

```sh
git add .
git commit -m "Initial working CI/CD pipeline for static web app"
git push origin main
```

### 5. **Verify Deployment**

- Go to the Actions tab in GitHub and confirm the workflow runs successfully.
- Visit the CloudFront URL (`website_url` output) to access your app.

---

## Demo Credentials

- **Email:** `hire-me@anshumat.org`
- **Password:** `HireMe@2025!`

---

## Monitoring & Logging

- S3 and CloudFront access logs can be enabled in Terraform for basic monitoring.
- All deployments are logged in GitHub Actions.

---


## Reasoning

This solution provides a secure, automated, and scalable way to deploy a static web app using AWS and DevOps best practices. The use of Terraform and GitHub Actions ensures reproducibility and easy management of infrastructure and deployments.

---
